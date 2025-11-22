#!/bin/bash

# Function to check the success of commands
check_success() {
    if [ $? -ne 0 ]; then
        echo "Error: $1 failed."
        exit 1
    fi
}

# Function to clone a Git repository if the target directory doesn't exist
clone_if_not_exists() {
    local repo_url="$1"
    local target_dir="$2"

    if [ -d "$target_dir" ]; then
        echo "Directory already exists: $target_dir, skipping clone."
    else
        sudo git clone "$repo_url" "$target_dir"
        check_success "Cloning $(basename "$repo_url")"
    fi
}

# Required programs
required_cmds=("zsh" "curl" "make")
missing_cmds=()

# Check if required programs are installed
for cmd in "${required_cmds[@]}"; do
    if ! command -v "$cmd" &> /dev/null; then
        missing_cmds+=("$cmd")
    fi
done

# Report missing commands
if [ ${#missing_cmds[@]} -ne 0 ]; then
    echo "Error: The following required programs are not installed:"
    for cmd in "${missing_cmds[@]}"; do
        echo "- $cmd"
    done
    echo "Please install the missing programs before running this script."
    exit 1
fi

# Define font URLs and their corresponding file names
FONT_URLS=(
    "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
    "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
    "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
    "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
)

FONT_NAMES=(
    "MesloLGS NF Regular.ttf"
    "MesloLGS NF Bold.ttf"
    "MesloLGS NF Italic.ttf"
    "MesloLGS NF Bold Italic.ttf"
)

# Prompt for font installation scope
read -p "Install fonts for just this user (user space) or for all users (shared/system-wide)? [user/shared, default: shared]: " FONT_SCOPE
FONT_SCOPE=${FONT_SCOPE:-shared}

if [[ "$FONT_SCOPE" =~ ^[Uu][Ss][Ee][Rr]$ ]]; then
    FONT_DIR="$HOME/.local/share/fonts/MesloLGS"
    CACHE_CMD="fc-cache -fv \"$FONT_DIR\""
    SUDO_CMD=""
else
    FONT_DIR="/usr/share/fonts/truetype/MesloLGS"
    CACHE_CMD="sudo fc-cache -fv \"$FONT_DIR\""
    SUDO_CMD="sudo"
fi

# Create the fonts directory if it doesn't exist
$SUDO_CMD mkdir -p "$FONT_DIR"
check_success "Creating font directory"

# Download each font into the specified directory
for i in "${!FONT_URLS[@]}"; do
    FONT_URL="${FONT_URLS[$i]}"
    FONT_FILE="$FONT_DIR/${FONT_NAMES[$i]}"

    # Check if the font file already exists
    if [ -f "$FONT_FILE" ]; then
        echo "Font already exists: ${FONT_NAMES[$i]}, skipping download."
        continue
    fi

    echo "Downloading font: ${FONT_NAMES[$i]}..."
    $SUDO_CMD curl -L -o "$FONT_FILE" "$FONT_URL"
    check_success "Downloading ${FONT_NAMES[$i]}"
done

# Update the font cache
echo "Updating font cache..."
eval $CACHE_CMD
check_success "Unable to update fonts"

# Create a temporary directory for cloning repositories
temp_dir=$(mktemp -d)
check_success "Creating temporary directory"

# Clone Manjaro Zsh config
git clone https://github.com/Chrysostomus/manjaro-zsh-config.git "${temp_dir}/manjaro-zsh-config"
check_success "Cloning manjaro-zsh-config"

# Install Zsh configuration files
install -v -D -m644 "${temp_dir}/manjaro-zsh-config/.zshrc" "$HOME/.zshrc"
check_success "Installing .zshrc in $HOME"

sudo install -v -D -m644 "${temp_dir}/manjaro-zsh-config/.zshrc" "/root/.zshrc"
check_success "Installing root .zshrc"

# Move necessary files from the cloned repository
sudo mv "${temp_dir}/manjaro-zsh-config/manjaro-zsh-prompt" /usr/share/zsh/
check_success "Moving manjaro-zsh-prompt"

sudo mv "${temp_dir}/manjaro-zsh-config/manjaro-zsh-config" /usr/share/zsh/
check_success "Moving manjaro-zsh-config"

sudo mv "${temp_dir}/manjaro-zsh-config/p10k.zsh" /usr/share/zsh/
check_success "Moving p10k.zsh"

# Cleanup: Remove cloned repositories
rm -rf "${temp_dir}"
check_success "Removing temporary directory with cloned repositories"

# Copy p10k.zsh to ~/.p10k.zsh
cp /usr/share/zsh/p10k.zsh "$HOME/.p10k.zsh"
check_success "Copying p10k.zsh to $HOME/.p10k.zsh"


# Clone Zsh plugins
# Zsh autosuggestions
clone_if_not_exists "https://github.com/zsh-users/zsh-autosuggestions.git" "/usr/share/zsh/plugins/zsh-autosuggestions"
check_success "Unable to install zsh-autosuggestions"

# Zsh syntax highlighting
clone_if_not_exists "https://github.com/zsh-users/zsh-syntax-highlighting.git" "/usr/share/zsh/plugins/zsh-syntax-highlighting"
check_success "Unable to install zsh-syntax-highlighting"

# Zsh completions
clone_if_not_exists "https://github.com/zsh-users/zsh-completions.git" "/usr/share/zsh/plugins/zsh-completions"
check_success "Unable to install zsh-completions"

# Zsh history substring search
clone_if_not_exists "https://github.com/zsh-users/zsh-history-substring-search.git" "/usr/share/zsh/plugins/zsh-history-substring-search"
check_success "Unable to install zsh-history-substring-search"

# Powerlevel10k theme
clone_if_not_exists "https://github.com/romkatv/powerlevel10k.git" "/usr/share/zsh-theme-powerlevel10k"
check_success "Unable to install zsh-theme-powerlevel10k"


# Add Powerlevel10k to .zshrc
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >> "$HOME/.zshrc"
check_success "Adding Powerlevel10k to .zshrc"

echo "Zsh setup completed successfully."

# Get the current shell
current_shell=$(basename "$SHELL")
echo "Your current default shell is: $current_shell"

# Ask for confirmation to change the default shell to Zsh
read -p "Do you want to change your default shell to Zsh? (y/n): " -n 1 -r
echo    # Move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Change the default shell
    chsh -s "$(which zsh)"
    echo "Default shell changed to Zsh. Please log out and log back in for the changes to take effect."
else
    echo "No changes made."
fi
