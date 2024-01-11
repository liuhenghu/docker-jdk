FROM 1005663978/jdk11:debian11

RUN apt update && apt install ca-certificates curl gnupg  --no-install-recommends -y && mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key |  gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    rm -rf /var/lib/apt/lists/*;

ENV NODE_MAJOR 20
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | \
    tee /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get install -y nodejs --no-install-recommends && \
    npm install -g topojson-server && \
    rm -rf /var/lib/apt/lists/*

RUN  apt update && apt install -y libczmq-dev --no-install-recommends && rm -rf /var/lib/apt/lists/*

ADD geos.tar.gz  /
