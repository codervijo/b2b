FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
	apt-get install -y  python3 build-essential

RUN apt-get install -y \
    make \
    automake \
    autotools-dev \
    libedit-dev \
    libjemalloc-dev \
    libncurses-dev \
    libpcre2-dev \
    libtool \
    pkg-config \
    python3-docutils \
    python3-sphinx \
    cpio

RUN apt-get install -y git graphviz autoconf-archive vim
RUN apt-get install -y cscope gdb
RUN apt-get install -y splint valgrind
RUN apt-get install -y python3-pip
RUN apt-get remove  -y golang
RUN apt-get autoremove -y
RUN apt-get install -y golang-1.20 wget

# download go tar
ENV GOVERSION="1.22.2"
RUN (cd /root && PATH=/usr/lib/go-1.20/bin/:$PATH wget -O go.tgz https://dl.google.com/go/go${GOVERSION}.src.tar.gz) 
RUN (cd /root && tar -C /usr/local -xzf go.tgz)

# compile code
ENV GOROOT=/usr/local/go/
RUN (cd /usr/local/go/src/ && PATH=/usr/lib/go-1.20/bin/:$PATH GOARCH=amd64 GOOS=linux ./all.bash)
RUN apt-get remove -y golang-1.20
ENV GOPATH=${GOROOT} 
ENV PATH=$PATH:$GOPATH/bin 
