
echo
echo This script will install fblualib and all its dependencies.
echo It has been Ubuntu 16.04, Linux x86_64.
echo

set -e
set -x


if [[ $(arch) != 'x86_64' ]]; then
    echo "x86_64 required" >&2
    exit 1
fi

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

dir=$(mktemp --tmpdir -d fblualib-build.XXXXXX)

echo Working in $dir
echo
cd $dir

echo Installing required packages
echo
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
    $extra_packages \
    flex \
    bison \
    libkrb5-dev \
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

echo
echo Cloning repositories
echo

git clone --depth 1 https://github.com/facebook/folly
git clone --depth 1 https://github.com/facebook/fbthrift
git clone https://github.com/jgoenetxea/thpp
git clone https://github.com/facebook/fblualib
git clone https://github.com/facebook/wangle

git clone https://github.com/no1msd/mstch

echo
echo Building folly
echo

cd $dir/folly/folly
autoreconf -ivf
./configure
make
sudo make install
sudo ldconfig

echo
echo Building mstch
echo

cd $dir/mstch
mkdir build
cd build
cmake ..
make
sudo make install

if [ $current -eq 1 ]; then
    echo
    echo Wangle
    echo

    cd $dir/wangle/wangle
    cmake .
    make
    sudo make install
fi


echo
echo Building Zstand
echo

cd $dir
wget https://github.com/facebook/zstd/archive/v1.0.0.zip
unzip v1.0.0.zip
cd $dir/zstd-1.0.0
sudo make install


echo
echo Building fbthrift
echo

cd $dir/fbthrift/thrift
autoreconf -ivf
./configure
make
sudo make install

echo
echo 'Installing TH++'
echo

cd $dir/thpp/thpp
./build.sh

echo
echo 'Installing FBLuaLib'
echo

cd $dir/fblualib/fblualib
./build.sh
cd $dir/fblualib/fblualib/python
luarocks make rockspec/fbpython-0.1-1.rockspec

echo
echo 'Almost done!'
echo

cd $dir
git clone https://github.com/torch/nn 
cd nn
luarocks make rocks/nn-scm-1.rockspec 

cd $dir
git clone https://github.com/jgoenetxea/fbtorch.git
cd fbtorch 
luarocks make rocks/fbtorch-scm-1.rockspec


echo
echo 'All done!'
echo
