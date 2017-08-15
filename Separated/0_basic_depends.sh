echo Installing required packages
echo

issue=$(cat /etc/issue)
extra_packages=
current=0
if [[ $issue =~ ^Ubuntu\ 16\.04 ]]; then
    extra_packages=libiberty-dev
    current=1
elif [[ $issue =~ ^Ubuntu\ 17\.04 ]]; then
	extra_packages=libiberty-dev
    current=1
else
    echo "Ubuntu 16.04 or 17.04 required" >&2
    exit 1
fi

sudo apt-get install -y \
    git \
    curl \
    wget \
    g++ \
    automake \
    autoconf \
    autoconf-archive \
    libtool \
    libboost-all-dev \
    libevent-dev \
    libdouble-conversion-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    liblz4-dev \
    liblzma-dev \
    libsnappy-dev \
    make \
    zlib1g-dev \
    binutils-dev \
    libjemalloc-dev \
    flex \
    bison \
    libkrb5-dev \
	$extra_packages \
    libsasl2-dev \
    libnuma-dev \
    pkg-config \
    libssl-dev \
    libedit-dev \
    libmatio-dev \
    libpython-dev \
    libpython3-dev \
    python-numpy \
    liblua5.2-dev
