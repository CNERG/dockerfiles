FROM ubuntu:18.04

ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV HOME /root
RUN apt-get clean -y

RUN apt-get update
RUN apt-get install -y --fix-missing \
    software-properties-common wget g++ \
    build-essential python3-numpy python3-scipy cython python3-setuptools \
    python3-nose git cmake vim emacs gfortran libblas-dev \
    liblapack-dev libhdf5-dev libhdf5-serial-dev gfortran python3-tables \
    python3-matplotlib python3-jinja2 python3-dev libpython3-dev \
    autoconf libtool python-setuptools python3-pip doxygen 
RUN apt-get clean -y
                       
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10
RUN pip3 install sphinx \
    cloud_sptheme \
    prettytable \
    sphinxcontrib_bibtex \
    numpydoc \
    nbconvert \
    numpy 

# make starting directory
RUN mkdir -p $HOME/opt
RUN echo "export PATH=$HOME/.local/bin:\$PATH" >> ~/.bashrc \
    && echo "alias build_pyne='python3 setup.py install --user -j 3 -DMOAB_LIBRARY=\$HOME/opt/moab/lib -DMOAB_INCLUDE_DIR=\$HOME/opt/moab/include'" >> ~/.bashrc \
    && echo "alias python=python3" >> ~/.bashrc \
    && echo "alias nosetests=nosetests3" >> ~/.bashrc

RUN gcc --version

# build MOAB
RUN cd $HOME/opt \
  && mkdir moab \
  && cd moab \
  && git clone https://bitbucket.org/fathomteam/moab \
  && cd moab \
  && git checkout -b Version5.0 origin/Version5.0 \
  && autoreconf -fi \
  && cd .. \
  && mkdir build \
  && cd build \
  && ../moab/configure --enable-shared --enable-dagmc  --enable-pymoab \
                       --with-hdf5=/usr/lib/x86_64-linux-gnu/hdf5/serial \
                       --prefix=$HOME/opt/moab \
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
    && git checkout moab-5.0 \
    && mkdir bld \
    && cd bld \
    && cmake .. -DMOAB_DIR=$HOME/opt/moab \
             -DCMAKE_INSTALL_PREFIX=$INSTALL_PATH \
    && make \
    && make install

# Install PyNE
RUN pip3 install cython --force-reinstall
RUN cd $HOME/opt \
    && git clone https://github.com/cnerg/pyne.git \
    && cd pyne \
    && python3 setup.py install --user \
                                --moab $HOME/opt/moab --dagmc $HOME/opt/dagmc --clean
ENV PYTHONPATH=$HOME/opt/moab/lib/python3.6/site-packages/

ENV PATH $HOME/.local/bin:$PATH
RUN cd $HOME && nuc_data_make

# Define default command
CMD ["/bin/bash"]
