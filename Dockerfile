FROM alpine:3.18.2

COPY . /tex_api

WORKDIR /tex_api

RUN apk add elixir erlang texlive-full imagemagick
RUN mix do local.hex --force, local.rebar --force, deps.get
CMD ["iex", "-S", "mix", "run"]
