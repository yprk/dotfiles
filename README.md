# dotfiles

Personal configuration files for macOS/Linux development environment.

## Overview

This repository contains my personal dotfiles for setting up a consistent development environment across different machines. The configurations are optimized for:

- **Shell**: Zsh with useful aliases, functions, and prompt customization
- **Git**: Enhanced git configuration with aliases and tools integration
- **Vim**: Modern vim setup with plugins and sensible defaults
- **Terminal**: Bash fallback configuration

## Features

### Zsh Configuration (`.zshrc`)
- Rich history management with search capabilities
- Git branch display in prompt
- Syntax highlighting and autosuggestions
- Useful aliases for git, docker, kubernetes, and more
- Custom functions for common tasks
- fzf integration for fuzzy finding

### Git Configuration (`.gitconfig`)
- Delta pager for better diffs
- GitHub CLI integration
- Useful git aliases
- Sensible defaults for push, pull, and merge behavior

### Vim Configuration (`.vimrc`)
- Modern vim settings with line numbers and syntax highlighting
- Plugin management with vim-plug
- File tree navigation with NERDTree
- Fuzzy file finding with fzf
- Git integration with fugitive
- Enhanced status line

### Bash Configuration (`.bashrc`)
- Fallback shell configuration
- Basic aliases and functions
- History management
- Cross-platform compatibility

### Custom Scripts (`bin/`)
- Custom utility scripts for development workflow
- Scripts are automatically installed to ~/.local/bin during setup

## Quick Start

### Automatic Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Run the installation script
./install.sh
```

The installation script will:
1. Create backups of existing dotfiles
2. Create symlinks to the dotfiles in this repo
3. Install custom bin scripts to ~/.local/bin
4. Optionally install recommended tools (Homebrew required on macOS)
5. Set up git configuration with your details

### Manual Installation

If you prefer to set up manually:

```bash
# Clone the repository
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles

# Create symlinks (backup your existing files first!)
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.bashrc ~/.bashrc

# Install bin scripts
mkdir -p ~/.local/bin
ln -sf ~/dotfiles/bin/* ~/.local/bin/
chmod +x ~/.local/bin/*

# Configure git with your details
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## Prerequisites

### Required
- Git
- Zsh (usually pre-installed on macOS)
- Vim

### Recommended Tools

#### macOS with Homebrew
```bash
# Install Homebrew first: https://brew.sh

# Essential tools
brew install fzf ripgrep git-delta

# Zsh plugins
brew install zsh-syntax-highlighting zsh-autosuggestions

# Vim plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

#### Linux (Ubuntu/Debian)
```bash
# Essential tools
sudo apt update
sudo apt install fzf ripgrep

# For git-delta, download from: https://github.com/dandavison/delta/releases

# Zsh plugins
sudo apt install zsh-syntax-highlighting zsh-autosuggestions

# Vim plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## Post-Installation

### Vim Plugins
After installation, open vim and install plugins:
```bash
vim
:PlugInstall
```

### Shell Restart
Restart your terminal or source the configuration:
```bash
source ~/.zshrc  # or ~/.bashrc
```

## Customization

### Personalizing Git Configuration

Edit the `.gitconfig` file and update:
- User name and email
- Any additional aliases you prefer
- Tool preferences (editor, merge tool, etc.)

### Modifying Zsh Configuration

Common customizations in `.zshrc`:
- Add your own aliases in the "Custom aliases" section
- Modify the prompt format
- Add additional tools or frameworks (Oh My Zsh, etc.)
- Configure additional plugins

### Vim Customization

To add more vim plugins, edit `.vimrc`:
1. Add `Plug 'plugin/name'` in the plug#begin() section
2. Run `:PlugInstall` in vim
3. Add any plugin-specific configuration below the plugins section

## File Structure

```
dotfiles/
├── .gitconfig          # Git configuration and aliases
├── .zshrc             # Zsh shell configuration
├── .vimrc             # Vim editor configuration
├── .bashrc            # Bash shell configuration (fallback)
├── bin/               # Custom scripts directory
├── install.sh         # Automated installation script
└── README.md          # This file
```

## Key Features Breakdown

### Aliases Available

#### Git Aliases (in shell)
- `g` = `git`
- `gs` = `git status`
- `ga` = `git add`
- `gc` = `git commit`
- `gp` = `git push`
- `gl` = `git pull`
- `gd` = `git diff`
- `gb` = `git branch`
- `gco` = `git checkout`
- `glog` = `git log --oneline --graph --decorate`

#### System Aliases
- `ll` = `ls -lah`
- `la` = `ls -la`
- `..` = `cd ..`
- `...` = `cd ../..`
- `proj` = `cd ~/projects`

#### Tool Aliases
- `k` = `kubectl`
- `d` = `docker`
- `tf` = `terraform`

### Custom Functions

- `mkcd()` - Create directory and cd into it
- `extract()` - Extract various archive formats
- `reload` - Reload shell configuration

### Custom Scripts (bin/)

The `bin/` directory contains custom utility scripts that enhance your development workflow. These scripts are automatically made available in your PATH when you run the installation script.

### Key Bindings

- `Ctrl+R` - Fuzzy history search (with fzf)
- `Ctrl+P`/`Ctrl+N` - History navigation
- `Ctrl+n` - Toggle NERDTree in vim
- `Ctrl+p` - Fuzzy file finder in vim

## Troubleshooting

### Zsh plugins not working
Make sure the plugins are installed:
```bash
brew install zsh-syntax-highlighting zsh-autosuggestions  # macOS
# or
sudo apt install zsh-syntax-highlighting zsh-autosuggestions  # Linux
```

### Vim plugins not loading
1. Ensure vim-plug is installed
2. Run `:PlugInstall` in vim
3. Restart vim

### fzf not working
Install fzf and run the install script:
```bash
brew install fzf  # macOS
$(brew --prefix)/opt/fzf/install

# or for Linux
sudo apt install fzf
```

## Contributing

Feel free to fork this repository and customize it for your own needs. If you have suggestions for improvements that would benefit others, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.