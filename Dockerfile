FROM fedora:latest

COPY . /tex_api

WORKDIR /tex_api
RUN dnf -y install @development-tools git elixir erlang texlive-latex texlive-standalone ImageMagick
RUN mix do local.hex --force, local.rebar --force, deps.get
CMD ["iex", "-S", "mix", "run"]
