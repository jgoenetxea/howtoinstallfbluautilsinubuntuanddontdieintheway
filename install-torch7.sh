
echo
echo This script will install Torch7 and all its dependencies.
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
else
    echo "Ubuntu 16.04 required" >&2
    exit 1
fi

git clone https://github.com/torch/distro.git ~/torch --recursive
cd ~/torch; bash install-deps;
TORCH_LUA_VERSION=LUA52 ./install.sh

source ~/.bashrc

