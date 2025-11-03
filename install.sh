#!/bin/bash

# Dotfiles installation script
# This script creates symlinks from your home directory to the dotfiles in this repo

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}Starting dotfiles installation...${NC}"
echo -e "${BLUE}Dotfiles directory: ${DOTFILES_DIR}${NC}"

# Function to create backup and symlink
create_symlink() {
    local source_file="$1"
    local target_file="$2"

    # If target exists and is not a symlink, back it up
    if [ -e "$target_file" ] && [ ! -L "$target_file" ]; then
        echo -e "${YELLOW}Backing up existing $target_file to ${target_file}.backup${NC}"
        mv "$target_file" "${target_file}.backup"
    fi

    # Remove existing symlink if it exists
    [ -L "$target_file" ] && rm "$target_file"

    # Create the symlink
    ln -s "$source_file" "$target_file"
    echo -e "${GREEN}Created symlink: $target_file -> $source_file${NC}"
}

# Function to check prerequisites
check_prerequisites() {
    echo -e "${BLUE}Checking prerequisites...${NC}"

    # Check if running on macOS
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo -e "${GREEN}macOS detected${NC}"

        # Check for Homebrew
        if ! command -v brew &> /dev/null; then
            echo -e "${YELLOW}Homebrew not found. Install from: https://brew.sh${NC}"
        else
            echo -e "${GREEN}Homebrew found${NC}"
        fi
    fi

    # Check for git
    if ! command -v git &> /dev/null; then
        echo -e "${RED}Git is required but not installed${NC}"
        exit 1
    else
        echo -e "${GREEN}Git found${NC}"
    fi
}

# Function to install recommended tools
install_tools() {
    echo -e "${BLUE}Would you like to install recommended tools? (y/n)${NC}"
    read -r response

    if [[ "$response" =~ ^[Yy]$ ]]; then
        if [[ "$OSTYPE" == "darwin"* ]] && command -v brew &> /dev/null; then
            echo -e "${BLUE}Installing recommended tools with Homebrew...${NC}"

            # Essential tools
            brew install fzf ripgrep git-delta

            # Zsh plugins
            brew install zsh-syntax-highlighting zsh-autosuggestions

            # Vim plugin manager
            echo -e "${BLUE}Installing vim-plug...${NC}"
            curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
                https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

            echo -e "${GREEN}Tools installed successfully!${NC}"
            echo -e "${YELLOW}Don't forget to run :PlugInstall in Vim to install vim plugins${NC}"
        else
            echo -e "${YELLOW}Homebrew not available. Please install tools manually:${NC}"
            echo "- fzf"
            echo "- ripgrep"
            echo "- git-delta"
            echo "- zsh-syntax-highlighting"
            echo "- zsh-autosuggestions"
        fi
    fi
}

# Main installation function
install_dotfiles() {
    echo -e "${BLUE}Installing dotfiles...${NC}"

    # Create symlinks for each dotfile
    files=(".gitconfig" ".zshrc" ".vimrc" ".bashrc")

    for file in "${files[@]}"; do
        if [ -f "$DOTFILES_DIR/$file" ]; then
            create_symlink "$DOTFILES_DIR/$file" "$HOME/$file"
        else
            echo -e "${YELLOW}Warning: $file not found in dotfiles directory${NC}"
        fi
    done
}

# Function to update git config with user details
setup_git() {
    echo -e "${BLUE}Setting up git configuration...${NC}"
    echo "Please enter your git user details:"

    read -p "Enter your name: " git_name
    read -p "Enter your email: " git_email

    if [ -n "$git_name" ] && [ -n "$git_email" ]; then
        git config --global user.name "$git_name"
        git config --global user.email "$git_email"
        echo -e "${GREEN}Git configuration updated${NC}"
    else
        echo -e "${YELLOW}Skipping git configuration setup${NC}"
    fi
}

# Main execution
main() {
    check_prerequisites
    install_dotfiles
    install_tools
    setup_git

    echo -e "${GREEN}✓ Dotfiles installation complete!${NC}"
    echo -e "${BLUE}Next steps:${NC}"
    echo "1. Restart your terminal or run: source ~/.zshrc"
    echo "2. If you installed vim-plug, open vim and run :PlugInstall"
    echo "3. Customize the dotfiles to your preferences"
    echo ""
    echo -e "${YELLOW}Note: Your original files have been backed up with .backup extension${NC}"
}

# Run main function
main "$@"