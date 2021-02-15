FROM ubuntu:18.04

ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV HOME /root
RUN apt-get update \
    && apt-get install -y --fix-missing \
            software-properties-common wget g++ \
            build-essential python-numpy python-scipy cython python-setuptools \
            python-nose git cmake vim emacs gfortran libblas-dev \
            liblapack-dev libhdf5-dev libhdf5-serial-dev gfortran python-tables \
            python-matplotlib python-jinja2 python-dev libpython-dev \
            autoconf libtool python-setuptools python-pip doxygen \
    && apt-get clean -y \
    && pip install sphinx \
            cloud_sptheme \
            prettytable \
            sphinxcontrib_bibtex \
            numpydoc \
            nbconvert \
            numpy 


# Define default command
CMD ["/bin/bash"]
