#!/bin/bash

# Exit on error
set -e

# Helper function to log messages with color
log() {
  echo -e "\033[1;34m$1\033[0m"
}

# Step 1: Install dependencies based on OS
install_dependencies() {
  log "Installing dependencies..."
  if [[ -f /etc/os-release ]]; then
    source /etc/os-release
    case "$ID" in
    ubuntu | debian)
      sudo apt update && sudo apt install -y \
        git zsh neovim tmux curl
      ;;
    fedora | rhel)
      sudo dnf install -y \
        git zsh neovim tmux curl
      ;;
    *)
      log "Unsupported OS: $ID"
      exit 1
      ;;
    esac
  else
    log "Cannot determine OS type. Exiting."
    exit 1
  fi
}

# Step 2: Clone and update submodules
clone_submodules() {
  log "Updating submodules..."
  git submodule update --init --recursive
}

# Step 3: Prompt user for Alacritty setup
# setup_alacritty() {
#   read -p "Do you want to set up Alacritty on this machine? (y/n): " setup_alacritty
#   if [[ "$setup_alacritty" == "y" ]]; then
#     log "Setting up Alacritty..."
#     mkdir -p ~/.config
#     ln -sfn ~/.dotfiles/alacritty ~/.config/alacritty
#   else
#     log "Skipping Alacritty setup."
#   fi
# }

# Step 3: Prompt user for Ghostty setup
setup_ghostty() {
  read -p "Do you want to set up Ghostty on this machine? (y/n): " setup_ghostty
  if [[ "$setup_ghostty" == "y" ]]; then
    log "Setting up Ghostty..."
    mkdir -p ~/.config

    # Install Ghostty based on OS
    if [[ -f /etc/os-release ]]; then
      source /etc/os-release
      case "$ID" in
      ubuntu | debian)
        # Ubuntu/Debian specific installation
        sudo apt update
        sudo apt install -y software-properties-common
        sudo add-apt-repository ppa:pgdev/ghostty -y
        sudo apt update
        sudo apt install -y ghostty
        ;;
      fedora | rhel)
        # Fedora/RHEL specific installation
        sudo dnf copr enable pgdev/ghostty -y
        sudo dnf install -y ghostty
        ;;
      *)
        log "Ghostty is not supported on this OS: $ID"
        exit 1
        ;;
      esac
    else
      log "Cannot determine OS type. Skipping Ghostty setup."
      return
    fi

    # Create configuration symlink
    ln -sfn ~/.dotfiles/ghostty ~/.config/ghostty
  else
    log "Skipping Ghostty setup."
  fi
}

# Step 4: Configure Neovim
setup_neovim() {
  log "Setting up Neovim..."
  mkdir -p ~/.config
  ln -sfn ~/.dotfiles/nvim ~/.config/nvim
  log "Open Neovim and run :Lazy, then press I to install plugins."
}

# Step 5: Configure Tmux
setup_tmux() {
  log "Setting up Tmux..."
  mkdir -p ~/.tmux/plugins
  ln -sfn ~/.dotfiles/tmux/plugins/tpm ~/.tmux/plugins/tpm
  ln -sfn ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
  log "Start Tmux and press Ctrl + a followed by I to install plugins."
}

# Step 6: Configure Zsh
setup_zsh() {
  log "Setting up Zsh..."
  ln -sfn ~/.dotfiles/zsh/zshrc ~/.zshrc

  # Powerlevel10k theme configuration
  ln -sfn ~/.dotfiles/zsh/p10k.zsh ~/.p10k.zsh

  # Install Oh My Zsh if not installed
  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    log "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi

  log "Ensure Zsh is set as the default shell..."
  if [[ "$SHELL" != "$(which zsh)" ]]; then
    chsh -s "$(which zsh)"
  fi
}

# Main script
log "Starting setup..."

install_dependencies
clone_submodules
# setup_alacritty
setup_ghostty
setup_neovim
setup_tmux
setup_zsh

log "Setup complete! Open Neovim, Tmux, and Zsh to ensure everything is working."
log "Don't forget to install the plugins in Tmux by running Ctrl + a followed by I."
log "Also don't forget to install the plugins in Neovim by running :Lazy, then pressing I."
