# Setup Instructions

After cloning the repository, follow these steps to configure Vim, Neovim, and Tmux:

## Submodule cloning

```sh
    git submodule update --init --recursive
```

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

## Alacritty Configuration

1. Create symbolic link for Alacritty configuration:
    ```bash
    ln -s ~/.dotfiles/alacritty/ ~/.config/alacritty
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


## Optional set NVIM as git core editor

```sh
    git config --global core.editor "nvim"
```
