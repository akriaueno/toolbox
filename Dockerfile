FROM debian:latest AS runner
ENV USER toolbox
ENV HOME /home/$USER
ENV TERM xterm-256color

RUN apt update && \
    apt upgrade && \
    apt install -y \
    git \
    sudo \
    python3 \
    python3-pip \
    neovim \
    tmux

RUN useradd $USER -mp '' -G sudo 

USER $USER
WORKDIR $HOME

COPY --chown=$USER:$USER ./config $HOME/.config
RUN pip3 install --user pynvim --upgrade msgpack

ENTRYPOINT ["bash", "-l"]
