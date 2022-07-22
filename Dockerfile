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
# set volume for file share between linux and windows
VOLUME [ "/root/", "/root/repos" ]
# end 

# bash
ADD bashrc /root/.bashrc
# end

# zsh
RUN zsh -c 'git clone https://code.aliyun.com/412244196/prezto.git "$HOME/.zprezto"' &&\
    zsh -c 'setopt EXTENDED_GLOB' &&\
    zsh -c 'for rcfile in "$HOME"/.zprezto/runcoms/z*; do ln -s "$rcfile" "$HOME/.${rcfile:t}"; done'
ENV SHELL /bin/zsh
RUN echo 'source /root/.bashrc' >> /root/.zshrc
# end

# Dev env for JS
ENV PNPM_HOME /root/.local/share/pnpm
ENV PATH $PNPM_HOME:$PATH
RUN yes | pacman -S nodejs npm &&\
    npm config set registry=https://registry.npmmirror.com &&\
		corepack enable &&\
		pnpm setup &&\
# end