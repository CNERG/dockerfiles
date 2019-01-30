FROM ubuntu:18.04

ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV HOME /root
RUN apt-get clean -y

RUN apt-get update
RUN apt-get update
RUN apt-get install -y --fix-missing \
    software-properties-common wget g++ \
    build-essential python-numpy python-scipy cython python-setuptools \
    python-nose git cmake vim emacs gfortran libblas-dev \
    liblapack-dev libhdf5-dev libhdf5-serial-dev gfortran python-tables \
    python-matplotlib python-jinja2 python-dev libpython-dev \
    autoconf libtool python-setuptools python-pip doxygen 
RUN apt-get clean -y
                       
RUN pip install sphinx \
    cloud_sptheme \
    prettytable \
    sphinxcontrib_bibtex \
    numpydoc \
    nbconvert \
    numpy 

# make starting directory
RUN mkdir -p $HOME/opt
RUN echo "export PATH=$HOME/.local/bin:\$PATH" >> ~/.bashrc \
    && echo "alias build_pyne='python setup.py install --user -j 3 -DMOAB_LIBRARY=\$HOME/opt/moab/lib -DMOAB_INCLUDE_DIR=\$HOME/opt/moab/include'" >> ~/.bashrc \
    && echo "alias python=python" >> ~/.bashrc \
    && echo "alias nosetests=nosetests3" >> ~/.bashrc

RUN pip install cython --force-reinstall

# build MOAB
RUN cd $HOME/opt \
  && mkdir moab \
  && cd moab \
  && git clone https://bitbucket.org/fathomteam/moab \
  && cd moab \
  && git checkout -b Version5.1.0 origin/Version5.1.0 \
  && cd .. \
  && mkdir build \
  && cd build \
  && ls ../moab/ \
  && cmake ../moab/ \
        -DCMAKE_INSTALL_PREFIX=$HOME/opt/moab \
        -DENABLE_HDF5=ON \
  && make -j 3 \
  && make install \
  && cmake ../moab/ \
        -DCMAKE_INSTALL_PREFIX=$HOME/opt/moab \
        -DENABLE_HDF5=ON \
        -DBUILD_SHARED_LIBS=OFF \
  && make -j 3 \
  && make install \
  && cd .. \
  && rm -rf build moab

# put MOAB on the path
ENV LD_LIBRARY_PATH $HOME/opt/moab/lib:$LD_LIBRARY_PATH
ENV LIBRARY_PATH $HOME/opt/moab/lib:$LIBRARY_PATH


ENV INSTALL_PATH=$HOME/opt/dagmc
RUN ls $HOME/opt/moab
RUN cd /root \\
    && git clone https://github.com/svalinn/DAGMC.git \
    && cd DAGMC \
    && git checkout develop \
    && mkdir bld \
    && cd bld \
    && cmake .. -DMOAB_DIR=$HOME/opt/moab \
             -DCMAKE_INSTALL_PREFIX=$INSTALL_PATH \
    && make \
    && make install

# Install PyNE
RUN cd $HOME/opt \
    && git clone https://github.com/cnerg/pyne.git \
    && cd pyne \
    && git checkout pymoab_cleanup \
    && python setup.py install --user \
                                --moab $HOME/opt/moab --dagmc $HOME/opt/dagmc --clean
ENV PYTHONPATH=$HOME/opt/moab/lib/python2.7/site-packages/

ENV PATH $HOME/.local/bin:$PATH
RUN cd $HOME && nuc_data_make

# Define default command
CMD ["/bin/bash"]
