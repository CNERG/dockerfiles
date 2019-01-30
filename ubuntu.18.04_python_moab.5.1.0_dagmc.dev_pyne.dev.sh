#!/bin/bash


py_v="3.6"
if [ ! $# -eq 1 ]; then
    echo "Python version not specified!"
    echo "Using default version: 3.6"
elif [ $1 == "3.6" ] || [ $1 == "2.7" ]; then
    py_v=$1
else 
    echo "2.7 and 3.6 are the only supported Python version !"
    echo "Using default version: 3.6"
fi

# build Ubuntu 18.04 with required python version
docker build -t ubuntu.18.04_py:${py_v} -f ubuntu/u.18.04.py.${py_v}.dockerfile .
# build moab
docker build -t ubuntu.18.04_python.${py_v}_moab:5.1.0 -f moab/u.18.04_py.${py_v}_moab.5.1.0.dockerfile .
# build dagmc
docker build -t ubuntu.18.04_python.${py_v}_moab.5.1.0_dagmc:dev -f dagmc/u.18.04_py.${py_v}_moab.5.1.0_dagmc.dev.dockerfile .
# build pyne
docker build -t ubuntu.18.04_py.${py_v}_moab.5.1.0_dagmc.dev_pyne:dev -f pyne/u.18.04_py.${py_v}_moab.5.1.0_dagmc.dev_pyne.dev.dockerfile .

