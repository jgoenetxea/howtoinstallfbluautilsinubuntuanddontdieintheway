echo
echo Building mstch
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

dir=$(pwd)
echo Working in $dir
echo
cd $dir

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
rm -f v1.0.0.zip
cd $dir/zstd-1.0.0
sudo make install
