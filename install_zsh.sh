#!/bin/bash

# Set package directory
pkgdir="/"

# Check if Zsh is installed
if ! command -v zsh &> /dev/null; then
    echo "Error: Zsh is not installed. Please install Zsh before running this script."
    exit 1
fi

# Function to check the success of commands
check_success() {
    if [ $? -ne 0 ]; then
        echo "Error: $1 failed."
        exit 1
    fi
}

# Install Zsh configuration files
install -D -m644 .zshrc "${pkgdir}/home/${USER}/.zshrc"
check_success "Installing .zshrc in /home/${USER}"

install -D -m644 rootzshrc "${pkgdir}/root/.zshrc"
check_success "Installing root .zshrc"

# Create a temporary directory for cloning repositories
temp_dir=$(mktemp -d)
check_success "Creating temporary directory"

# Clone Manjaro Zsh config
git clone https://github.com/Chrysostomus/manjaro-zsh-config.git "${temp_dir}/manjaro-zsh-config"
check_success "Cloning manjaro-zsh-config"

# Move necessary files from the cloned repository
mv "${temp_dir}/manjaro-zsh-config/manjaro-zsh-prompt" /usr/share/zsh/
check_success "Moving manjaro-zsh-prompt"

mv "${temp_dir}/manjaro-zsh-config/p10k.zsh" /usr/share/zsh/
check_success "Moving p10k.zsh"

# Copy p10k.zsh to ~/.p10k.zsh
cp /usr/share/zsh/p10k.zsh "${pkgdir}/home/${USER}/.p10k.zsh"
check_success "Copying p10k.zsh to ~/.p10k.zsh"

# Clone Zsh plugins
# Zsh autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions.git "${pkgdir}/usr/share/zsh/plugins/zsh-autosuggestions"
check_success "Cloning zsh-autosuggestions"

# Zsh syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${temp_dir}/zsh-syntax-highlighting"
check_success "Cloning zsh-syntax-highlighting"

cd "${temp_dir}/zsh-syntax-highlighting" || exit
make install
check_success "Installing zsh-syntax-highlighting"
mv /usr/local/share/zsh-syntax-highlighting "${pkgdir}/usr/share/zsh/plugins/zsh-syntax-highlighting"
check_success "Moving zsh-syntax-highlighting to the correct directory"
cd - || exit

# Zsh completions
git clone https://github.com/zsh-users/zsh-completions.git "${pkgdir}/usr/share/zsh/plugins/zsh-completions"
check_success "Cloning zsh-completions"

# Zsh history substring search
git clone https://github.com/zsh-users/zsh-history-substring-search.git "${pkgdir}/usr/share/zsh/plugins/zsh-history-substring-search"
check_success "Cloning zsh-history-substring-search"

# Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${pkgdir}/usr/share/zsh/theme-powerlevel10k"
check_success "Cloning Powerlevel10k theme"

# Cleanup: Remove cloned repositories
rm -rf "${temp_dir}"
check_success "Removing temporary directory with cloned repositories"

# Add Powerlevel10k to .zshrc
echo 'source /usr/share/zsh/theme-powerlevel10k/powerlevel10k.zsh-theme' >> "${pkgdir}/home/${USER}/.zshrc"
check_success "Adding Powerlevel10k to .zshrc"

echo "Zsh setup completed successfully."
