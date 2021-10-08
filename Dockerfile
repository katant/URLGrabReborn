FROM ubuntu:bionic
RUN apt-get update && apt-get install -y gnupg --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 648ACFD622F3D138 0E98404D386FA1D9
RUN echo deb http://deb.debian.org/debian buster-backports main contrib > /etc/apt/sources.list.d/backports.list
RUN apt-get update && apt-get install -y git-core libgnutls28-dev lua5.1 liblua5.1-0 liblua5.1-0-dev screen bzip2 zlib1g-dev flex autoconf autopoint texinfo gperf lua-socket rsync automake pkg-config python3-dev python3-pip build-essential gettext wget --no-install-recommends && apt-get -t buster-backports install zstd libzstd-dev libzstd1 --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN python3 -m pip install setuptools wheel
RUN python3 -m pip install --upgrade seesaw2 zstandard requests 
RUN git clone https://github.com/ArchiveTeam/urls-grab
RUN ./urls-grab/get-wget-lua.sh
RUN apt-get autoremove -o APT::Autoremove::RecommendsImportant=0 -o APT::Autoremove::SuggestsImportant=0 -y
RUN cp wget-at /urls-grab/wget-at
ENTRYPOINT [ "run-pipeline3", "/urls-grab/pipeline.py", "--disable-web-server" ]
