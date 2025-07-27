# jbertozzi's dotfiles

## Installation

```
sudo dnf isntall tmux rcm neovim -y
git clone https://github.com/jbertozzi/dotfiles.git .dotfiles
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cd .dotfiles
rcup
curl -o /tmp/Hack.zip -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hack.zip
fc-cache -vf ~/.local/share/fonts/unzip /tmp/Hack.zip -d ~/.local/share/fonts/
tmux
<tmux_prefix>I
```
