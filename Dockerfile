ARG BASE_IMAGE=ubuntu:20.04


FROM ${BASE_IMAGE}
ENV PATH /opt/conda/bin:$PATH
WORKDIR /home

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libasound2-dev \
    libsndfile1 \
    libjack-dev \
    ca-certificates \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# download model
RUN curl -fsSL -v -O  https://storage.googleapis.com/magentadata/models/music_vae/checkpoints/groovae_4bar.tar

# conda env
COPY /environment.yml /home/environment.yml

# isntall conda
RUN curl -fsSL -v -o ~/miniconda.sh -O  https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
    chmod +x ~/miniconda.sh && \
    ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda env update -n base --file environment.yml && \
    /opt/conda/bin/conda clean -ya
RUN pip install magenta

COPY ./run.sh /home/run.sh
RUN chmod +x /home/run.sh
CMD ["./run.sh"]


