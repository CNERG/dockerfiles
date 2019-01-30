FROM ubuntu.18.04_python.3.6_moab:5.1.0

ENV INSTALL_PATH=$HOME/opt/dagmc
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

# Define default command
CMD ["/bin/bash"]
