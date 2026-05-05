FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    gdb \
    sudo \
    git \
    vim \
    btop \
    zsh \
    curl \
    gnupg2 \
    openssh-client \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/zsh -G sudo gpadmin && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER gpadmin
WORKDIR /home/gpadmin

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

RUN git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-/home/gpadmin/.oh-my-zsh/custom}/plugins/zsh-autocomplete

RUN curl https://raw.githubusercontent.com/riogor/dotfiles/refs/heads/master/.zshrc -o ~/.zshrc

RUN curl https://raw.githubusercontent.com/riogor/dotfiles/refs/heads/master/.vimrc -o ~/.vimrc

CMD ["sleep", "infinity"]
