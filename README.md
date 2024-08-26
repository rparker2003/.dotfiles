Commands to run after cloning to get vim, nvim, and tmux working:


# Create symbolic link for Vim configuration files
ln -s ~/.dotfiles/vim/vimrc ~/.vimrc

ln -s ~/.dotfiles/vim/vim ~/.vim

Then run 'vim' and pun ':PlugInstall' to install the plugins.


# Create symbolic link for Neovim configuration
ln -s ~/.dotfiles/nvim ~/.config/nvim

Then run 'nvim' and run 'Lazy', then press 'I' to install the plugins.


# Create symbolic link for Tmux configuration
mkdir -p ~/.tmux/plugins

ln -s ~/.dotfiles/tmux/plugins/tpm ~/.tmux/plugins/tpm

ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf

Then run 'tmux' and press 'Ctrl + a' and 'I' to install the plugins.



# Setup Instructions

After cloning the repository, follow these steps to configure Vim, Neovim, and Tmux:

## Vim Configuration

1. **Create symbolic links for Vim configuration files:**

    ```sh
    ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
    ln -s ~/.dotfiles/vim/vim ~/.vim
    ```

2. **Install plugins:**

    Open Vim and run:

    ```vim
    :PlugInstall
    ```

## Neovim Configuration

1. **Create symbolic link for Neovim configuration:**

    ```sh
    ln -s ~/.dotfiles/nvim ~/.config/nvim
    ```

2. **Install plugins:**

    Open Neovim and run:

    ```lua
    :Lazy
    ```

    Then press `I` to install the plugins.

## Tmux Configuration

1. **Create symbolic link for Tmux configuration:**

    ```sh
    mkdir -p ~/.tmux/plugins
    ln -s ~/.dotfiles/tmux/plugins/tpm ~/.tmux/plugins/tpm
    ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
    ```

2. **Install plugins:**

    Start Tmux and press `Ctrl + a` followed by `I` to install the plugins.
