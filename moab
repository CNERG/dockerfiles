FROM ubuntu:16.04

RUN apt-get -y --force-yes update
RUN apt-get install -y --force-yes \
    software-properties-common python-software-properties wget

# moab specific dependencies
RUN apt-get install -y build-essential git cmake vim autoconf automake libtool libhdf5-dev libeigen3-dev \
    libblas-dev liblapack-dev gfortran


RUN \
    cd && \
    git clone --branch fortran_free --single-branch https://bitbucket.org/gonuke/moab

RUN \
    cd && \
    cd moab && \
    mkdir bld_cmake && \
    cd bld_cmake && \
    cmake .. -DCMAKE_C_FLAGS="-fPIC -DPIC" -DCMAKE_CXX_FLAGS="-fPIC -DPIC" -DBUILD_SHARED_LIBS=ON \
       -DCMAKE_SHARED_LINKER_FLAGS="-Wl,--no-undefined" -DENABLE_MPI=OFF  \
       -DENABLE_HDF5=ON -DHDF5_ROOT=/usr/lib/x86_64-linux-gnu/hdf5/serial \
       -DENABLE_NETCDF=OFF -DENABLE_METIS=OFF -DENABLE_IMESH=OFF -DENABLE_FBIGEOM=OFF && \
    make all VERBOSE=1 -j 8

RUN \
    cd && cd moab/bld_cmake && \
    make test VERBOSE=1 -j 8

    

