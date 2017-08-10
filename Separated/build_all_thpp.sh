echo
echo Download, build and install THPP
echo


echo
echo Building folly
echo

dir=$(pwd)
echo Working in $dir
echo
cd $dir

cd $dir
git clone --depth 1 https://github.com/facebook/folly
cd $dir/folly/folly
autoreconf -ivf
./configure
make
sudo make install
sudo ldconfig

echo
echo Building mstch
echo

cd $dir
git clone https://github.com/no1msd/mstch
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


# echo
# echo Building fbthrift
# echo

# cd $dir
# git clone --depth 1 https://github.com/facebook/fbthrift
# cd $dir/fbthrift/thrift
# autoreconf -ivf
# ./configure
# make
# sudo make install

echo
echo 'Installing TH++'
echo

cd $dir
git clone https://github.com/jgoenetxea/thpp
cd $dir/thpp/thpp
THPP_NOFB=1 ./build.sh
