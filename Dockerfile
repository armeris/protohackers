FROM bitwalker/alpine-elixir:1.14.0 as releaser

WORKDIR /app

# Install Hex + Rebar
RUN mix do local.hex --force, local.rebar --force

COPY mix.exs /app/
COPY mix.* /app/

ENV MIX_ENV=prod
RUN mix do deps.get --only $MIX_ENV, deps.compile

COPY . /app/

WORKDIR /app
RUN MIX_ENV=prod mix release

########################################################################

FROM bitwalker/alpine-elixir:1.14.0

EXPOSE 4004
ENV PORT=4004 \
    MIX_ENV=prod \
    SHELL=/bin/bash

WORKDIR /app
COPY --from=releaser app/_build/prod/rel/protohackers .

CMD ["./bin/protohackers", "start"]