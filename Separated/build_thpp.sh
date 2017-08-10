echo
echo 'Installing TH++'
echo

dir=$(pwd)
echo Working in $dir
echo
cd $dir

cd $dir
git clone https://github.com/jgoenetxea/thpp
cd $dir/thpp/thpp
THPP_NOFB=1 ./build.sh

