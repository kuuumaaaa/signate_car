FROM ubuntu:latest

# update
RUN apt-get -y update && apt-get install -y \
sudo \
wget \
vim

#install anaconda3
WORKDIR /opt
# download anaconda package and install anaconda
# archive -> https://repo.continuum.io/archive/
RUN wget https://repo.continuum.io/archive/Anaconda3-2019.10-Linux-x86_64.sh && \
sh /opt/Anaconda3-2019.10-Linux-x86_64.sh -b -p /opt/anaconda3 && \
rm -f Anaconda3-2019.10-Linux-x86_64.sh
# set path
ENV PATH /opt/anaconda3/bin:$PATH

# update pip and conda
RUN pip install --upgrade pip

#datasxience module
RUN pip install missingno\
    plotly\
    lightgbm\
    cufflinks\
    pandas-profiling

# RUN conda deactivate
# RUN conda install nodejs
RUN conda install -c conda-forge nodejs
RUN conda install -c conda-forge jupyterlab
RUN conda install -c conda-forge jupyter_contrib_nbextensions
# # RUN conda activate new_env
# # Jupyter widgets extension
# RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager@1.0 --no-build
# # FigureWidget support
# RUN jupyter labextension install plotlywidget@1.2.0 --no-build
# # and jupyterlab renderer support
# RUN jupyter labextension install jupyterlab-plotly@1.2.0 --no-build
# # JupyterLab chart editor support (optional)
# RUN jupyter labextension install jupyterlab-chart-editor --no-build
# # Build extensions (must be done to activate extensions since --no-build is used above)
# RUN jupyter lab build --minimize=False



# CMD conda install -c conda-forge pandas-profiling


WORKDIR /
RUN mkdir /work

# execute jupyterlab as a default command
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--LabApp.token=''"]