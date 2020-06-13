FROM debian:latest AS runner
ENV USER toolbox
ENV HOME /home/$USER
ENV TERM xterm-256color

RUN apt update && \
    apt upgrade && \
    apt install -y \
    bash-completion \
    git \
    lsof \
    man \
    neovim \
    python3 \
    python3-pip \
    sudo \
    tmux \
    xclip

RUN useradd $USER -mp '' -G sudo 

USER $USER
WORKDIR $HOME

RUN pip3 install --user pynvim --upgrade msgpack
    

COPY --chown=$USER:$USER ./config/.bashrc .bashrc
COPY --chown=$USER:$USER ./config/.tmux.conf .tmux.conf
COPY --chown=$USER:$USER ./config/nvim .config/

ENTRYPOINT ["bash", "-l"]
