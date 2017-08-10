echo
echo 'Installing FBLuaLib'
echo

dir=$(pwd)
echo Working in $dir
echo
cd $dir

# conda install numpy

git clone https://github.com/jgoenetxea/fblualib
# cd $dir/fblualib/fblualib
# ./build.sh
cd $dir/fblualib/fblualib/python
luarocks make rockspec/fbpython-0.1-1.rockspec
