#!/bin/bash

docker build -t ubuntu.18.04_py:3.6 -f ubuntu/u.18.04.py2.dockerfile .
docker build -t ubuntu.18.04_python.3.6_moab:5.1.0 -f moab/u.18.04_py.3.6_moab.5.1.0.dockerfile .
docker build -t ubuntu.18.04_python.3.6_moab.5.1.0_dagmc:dev -f dagmc/u.18.04_py.3.6_moab.5.1.0_dagmc.dev.dockerfile .
docker build -t ubuntu.18.04_py.3.6_moab.5.1.0_dagmc.dev_pyne:dev -f pyne/u.18.04_py.3.6_moab.5.1.0_dagmc.dev_pyne.dev.dockerfile .

