FROM alpine:edge

RUN apk add git neovim ripgrep tree-sitter alpine-sdk go nodejs npm bash unzip wget gzip --update

RUN adduser -D test

WORKDIR /home/test/.config/nvim

COPY . .

RUN chown -R test:test /home/test/

USER test
ENTRYPOINT [ "ash" ]
