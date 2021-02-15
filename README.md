# CNERG Dockerfiles

A set of dockerfiles to be shared among CNERG users for our mutual benefit and convenience.

ubuntu:
    -u.18.04.py.2.7: ubuntu 18.04 + python 2.7
    -u.18.04.py.3.6: ubuntu 18.04 + python 3.6

moab:
    - u.18.04_py.2.7_moab.5.1.0: moab 5.1.0 against ubuntu 18.04 + python 2.7
    - u.18.04_py.3.6_moab.5.1.0: moab 5.1.0 against ubuntu 18.04 + python 3.6

dagmc:
    - u.18.04_py.2.7_moab.5.1.0_dagmc.dev: dagmc develop against ubuntu 18.04 + python 2.7 + moab 5.1.0 
    - u.18.04_py.3.6_moab.5.1.0_dagmc.dev: dagmc develop against ubuntu 18.04 + python 3.6 + moab 5.1.0 

pyne:
    - u.18.04_py.2.7_moab.5.1.0_dagmc.dev_pyne.dev: pyne develop against ubuntu 18.04 + python 2.7 + moab 5.1.0 + dagmc develop 
    - u.18.04_py.3.6_moab.5.1.0_dagmc.dev_pyne.dev: pyne develop against ubuntu 18.04 + python 3.6 + moab 5.1.0 + dagmc develop 
