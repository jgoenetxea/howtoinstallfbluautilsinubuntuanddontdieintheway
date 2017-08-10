echo
echo Building fbthrift
echo

dir=$(pwd)
echo Working in $dir
echo
cd $dir

git clone --depth 1 https://github.com/facebook/fbthrift
cd $dir/fbthrift/thrift
autoreconf -ivf
./configure
make
sudo make install
