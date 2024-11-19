# Setup Instructions

After cloning the repository, follow these steps to clone sub-modules, and configure: Neovim, Tmux, Alacritty (optional), and ZSH:

## Automatic Setup

It only takes one command to setup this dotfiles repository!

```sh
   ./setup_dotfiles.sh
```

This script supports Ubuntu (debian) and Fedora (rhel) based systems. It will install the necessary packages automatically. It will also ask if you want to install the Alacritty configuration as most machines I use don't have it installed.

When installing ZSH, the installer will prompt for a change from bash to zsh for your default terminal. I always say "Yes" which leads to the installer hiding the setup script. Simply run `exit` to finish the installer. After a reboot, ZSH will be the default. However, you can access it with `zsh` in the meantime without rebooting!

<!-- ## Submodule cloning -->
<!---->
<!-- ```sh -->
<!--     git submodule update --init --recursive -->
<!-- ``` -->
<!---->
<!-- ## Vim Configuration -->
<!---->
<!-- 1. **Create symbolic links for Vim configuration files:** -->
<!---->
<!--     ```sh -->
<!--     ln -s ~/.dotfiles/vim/vimrc ~/.vimrc -->
<!--     ln -s ~/.dotfiles/vim/vim ~/.vim -->
<!--     ``` -->
<!---->
<!-- 2. **Install plugins:** -->
<!---->
<!--     Open Vim and run: -->
<!---->
<!--     ```vim -->
<!--     :PlugInstall -->
<!-- ``` -->
<!---->
<!-- ## Alacritty Configuration -->
<!---->
<!-- 1. Create symbolic link for Alacritty configuration: -->
<!--    ```bash -->
<!--    ln -s ~/.dotfiles/alacritty ~/.config/alacritty -->
<!--    ``` -->
<!---->
<!-- ## ZSH Configuration -->
<!---->
<!-- 1. Create symbolic link for ZSH configuration: -->
<!---->
<!--    ```bash -->
<!--    ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc -->
<!--    ``` -->
<!---->
<!-- 2. Download Oh-My-Zsh: -->
<!---->
<!-- ```bash -->
<!--    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -->
<!-- ``` -->
<!---->
<!-- ## Neovim Configuration -->
<!---->
<!-- 1. **Create symbolic link for Neovim configuration:** -->
<!---->
<!--    ```sh -->
<!--    ln -s ~/.dotfiles/nvim ~/.config/nvim -->
<!--    ``` -->
<!---->
<!-- 2. **Install plugins:** -->
<!---->
<!--    Open Neovim and run: -->
<!---->
<!--    ```lua -->
<!--    :Lazy -->
<!--    ``` -->
<!---->
<!--    Then press `I` to install the plugins. -->
<!---->
<!-- ## Tmux Configuration -->
<!---->
<!-- 1. **Create symbolic link for Tmux configuration:** -->
<!---->
<!--    ```sh -->
<!--    mkdir -p ~/.tmux/plugins -->
<!--    ln -s ~/.dotfiles/tmux/plugins/tpm ~/.tmux/plugins/tpm -->
<!--    ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf -->
<!--    ``` -->
<!---->
<!-- 2. **Install plugins:** -->
<!---->
<!--    Start Tmux and press `Ctrl + a` followed by `I` to install the plugins. -->
<!---->
<!-- ## Optional set NVIM as git core editor -->
<!---->
<!-- ```sh -->
<!--     git config --global core.editor "nvim" -->
<!-- ``` -->
