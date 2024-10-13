# Manjaro Zsh Configuration Script

This script automates the installation and configuration of Zsh along with essential plugins and themes, using the `manjaro-zsh-config` repository as a base. It is designed for Manjaro users who want to quickly set up a consistent Zsh environment across multiple machines.

## Features

- Installs Zsh and configures `.zshrc` for the current user and root.
- Clones and sets up the `manjaro-zsh-config` repository.
- Installs popular Zsh plugins including:
  - zsh-autosuggestions
  - zsh-syntax-highlighting
  - zsh-completions
  - zsh-history-substring-search
- Installs the Powerlevel10k theme for a customizable prompt.
- Copies the `p10k.zsh` configuration file to the user's home directory.

## Requirements

- Zsh must be installed on the system. If not, the script will prompt for installation.
- Internet connection for cloning repositories.

## Usage

1. **Clone this repository:**

   ```bash
   git clone https://github.com/yourusername/manjaro-zsh-config-script.git
   cd manjaro-zsh-config-script
   ```

2. **Make the script executable:**

   ```bash
   chmod +x install_zsh.sh
   ```

3. **Run the script:**

   ```bash
   ./install_zsh.sh
   ```

4. **Restart your terminal** or run `source ~/.zshrc` to apply the changes.

## Customization

You can customize the script to suit your preferences, such as modifying the plugins or themes that are installed. Simply edit the `install_zsh.sh` script before running it.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Chrysostomus/manjaro-zsh-config](https://github.com/Chrysostomus/manjaro-zsh-config) for the base configuration.
- Various Zsh plugins and themes that enhance the terminal experience.

## Contributing

If you find any issues or have suggestions for improvements, feel free to open an issue or submit a pull request.



### Instructions for Committing to GitHub
1. Create a new directory for your project.
2. Inside that directory, create the `install_zsh.sh` script with your installation script code.
3. Create a `README.md` file and paste the content provided above.
4. Add a `.gitignore` file if you want to exclude specific files or directories.
5. Initialize a git repository, add your files, and commit:

   ```bash
   git init
   git add install_zsh.sh README.md
   git commit -m "Initial commit: Add Zsh configuration script"
   ```

6. Link your local repository to GitHub and push:

   ```bash
   git remote add origin https://github.com/yourusername/manjaro-zsh-config-script.git
   git push -u origin master
   ```

Replace `yourusername` with your GitHub username. This setup will allow you to easily replicate your Zsh configuration across all your machines.
