from ubuntu.18.04_python.2.7_moab.5.1.0_dagmc:dev

# Install PyNE
RUN cd $HOME/opt \
    && git clone https://github.com/cnerg/pyne.git \
    && cd pyne \
    && git checkout pymoab_cleanup \
    && python setup.py install --user \
                                --moab $HOME/opt/moab --dagmc $HOME/opt/dagmc --clean

ENV PATH $HOME/.local/bin:$PATH
RUN cd $HOME && nuc_data_make

# Define default command
CMD ["/bin/bash"]
