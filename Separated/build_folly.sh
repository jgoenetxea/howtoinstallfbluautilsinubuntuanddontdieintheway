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

