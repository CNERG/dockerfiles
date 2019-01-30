#!/bin/bash

docker build -t ubuntu.18.04_py:2.7 -f ubuntu/u.18.04.py2.dockerfile .
docker build -t ubuntu.18.04_python.2.7_moab:5.1.0 -f moab/u.18.04_py.2.7_moab.5.1.0.dockerfile .
docker build -t ubuntu.18.04_python.2.7_moab.5.1.0_dagmc:dev -f dagmc/u.18.04_py.2.7_moab.5.1.0_dagmc.dev.dockerfile .
docker build -t ubuntu.18.04_py.2.7_moab.5.1.0_dagmc.dev_pyne:dev -f pyne/u.18.04_py.2.7_moab.5.1.0_dagmc.dev_pyne.dev.dockerfile .

