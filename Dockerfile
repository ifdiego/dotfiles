FROM fedora:44

RUN dnf install -y --setopt=install_weak_deps=False \
        git \
        curl \
        ca-certificates \
        tar \
        gzip \
        unzip \
        sudo \
        gcc \
        gcc-c++ \
        make \
        cmake \
        pkgconf-pkg-config \
        openssl-devel \
    && dnf clean all

# Fedora mirrors sometimes stall; retry instead of failing the whole build.
RUN printf '\nretries=10\ntimeout=120\nminrate=200\n' >> /etc/dnf/dnf.conf

RUN groupadd --gid 1000 diego \
    && useradd --create-home --uid 1000 --gid 1000 --shell /usr/bin/fish diego \
    && echo 'diego ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/diego \
    && chmod 0440 /etc/sudoers.d/diego

USER diego
ENV HOME=/home/diego
ENV PATH=/home/diego/.local/bin:/home/diego/.local/share/pnpm:/home/diego/.cargo/bin:/home/linuxbrew/.linuxbrew/bin:/usr/local/bin:/usr/bin:/bin
ENV SHELL=/usr/bin/fish
ENV LANG=C.UTF-8

RUN curl -fsSL https://mise.run | sh

WORKDIR /home/diego/Documents/dotfiles
COPY --chown=diego:diego . .
RUN mise trust

RUN mise bootstrap --yes --skip repos,user

RUN fish --no-config -c 'curl -fsSL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update'

CMD ["fish", "-l"]
