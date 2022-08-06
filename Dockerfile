FROM archlinux:base-devel

WORKDIR /tmp
ENV SHELL /bin/bash
# add mirrorlist for chinese user
ADD mirrorlist /etc/pacman.d/mirrorlist
# use pacman(archlinux package manager) update all package
# S stands for sync
# y is for refresh (local cache)
# u is for system update
RUN yes | pacman -Syu 
# download git zsh
RUN yes | pacman -S git zsh
RUN mkdir -p /root/.config
# set volume for file share between linux and windows
VOLUME [ "/root/.config", "/root/", "/root/repos" ]
# end 

# bash
ADD bashrc /root/.bashrc
ADD z /root/.config/z
# end

# zsh
RUN zsh -c 'git clone https://code.aliyun.com/412244196/prezto.git "$HOME/.zprezto"' &&\
    zsh -c 'setopt EXTENDED_GLOB' &&\
    zsh -c 'for rcfile in "$HOME"/.zprezto/runcoms/z*; do ln -s "$rcfile" "$HOME/.${rcfile:t}"; done'
ENV SHELL /bin/zsh
RUN echo 'source /root/.bashrc' >> /root/.zshrc
RUN echo 'source /root/.config/z/z.sh' >> /root/.zshrc
# end

# basic tools
RUN yes | pacman -S curl tree
ENV EDITOR=vim
ENV VISUAL=vim
# end


# Dev env for JS
ENV PNPM_HOME /root/.local/share/pnpm
ENV PATH $PNPM_HOME:$PATH
# -S: Sync packages
# -yy: refresh package database, force refresh even if local database appears up-to-date
RUN yes | pacman -Syy && yes | pacman -S nodejs npm &&\
    npm config set registry=https://registry.npmmirror.com &&\
    corepack enable &&\
    pnpm setup &&\
    pnpm i -g http-server
# end

# tools

# fzf is a general-purpose command-line fuzzy finder
RUN yes | pacman -S fzf openssh exa the_silver_searcher fd rsync &&\
    ssh-keygen -t rsa -N '' -f /etc/ssh/ssh_host_rsa_key &&\
    ssh-keygen -t dsa -N '' -f /etc/ssh/ssh_host_dsa_key

# end