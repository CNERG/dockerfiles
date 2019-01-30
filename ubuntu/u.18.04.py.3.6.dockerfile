FROM ubuntu:18.04

ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV HOME /root

RUN apt-get update \
    && apt-get install -y --fix-missing \
    software-properties-common wget g++ \
    build-essential python3-numpy python3-scipy cython python3-setuptools \
    python3-nose git cmake vim emacs gfortran libblas-dev \
    liblapack-dev libhdf5-dev libhdf5-serial-dev gfortran python3-tables \
    python3-matplotlib python3-jinja2 python3-dev libpython3-dev \
    autoconf libtool python-setuptools python3-pip doxygen \
    && apt-get clean -y \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3 10
RUN pip3 install --force-reinstall \
    sphinx \
    cloud_sptheme \
    prettytable \
    sphinxcontrib_bibtex \
    numpydoc \
    nbconvert \
    cython

# Define default command
CMD ["/bin/bash"]
