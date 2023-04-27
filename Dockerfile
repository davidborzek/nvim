FROM archlinux:latest

RUN pacman -Syu --noconfirm

RUN pacman -S --noconfirm \
    git \
    neovim \
    ripgrep \
    tree-sitter \
    go \
    nodejs \
    npm \
    base-devel \
    bash \
    unzip \
    wget \
    gzip


RUN useradd -m -U -s /bin/bash nvim
USER nvim
WORKDIR /home/nvim

COPY --chown=nvim:nvim . .config/nvim

ENTRYPOINT [ "bash" ]



