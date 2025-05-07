# Manjaro Zsh Configuration Script

This script automates the installation and configuration of Zsh along with essential plugins and themes, using the `manjaro-zsh-config` repository as a base. It is designed for Linux users who love Manjaro Zsh config and want to quickly set up a consistent Zsh environment across multiple machines.

## Features

- Installs Zsh and configures `.zshrc` for the current user and root.
- Installs the MesloLGS NF font
- Clones and sets up the `manjaro-zsh-config` repository.
- Installs popular Zsh plugins including:
  - zsh-autosuggestions
  - zsh-syntax-highlighting
  - zsh-completions
  - zsh-history-substring-search
- Installs the Powerlevel10k theme for a customizable prompt.
- Copies the `p10k.zsh` configuration file to the user's home directory.

## Requirements

- Zsh
- Curl
- Make
- Git


## Usage

1. **Clone this repository:**

   ```bash
   git clone https://github.com/AdamF42/manjaro-zsh-config-install.git
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

5. **Select the MesloLGS NF font**

After running the script, make sure to select the MesloLGS NF font in your terminal emulator. Refer to the following link for instructions: [Powerlevel10k Font Installation](https://github.com/romkatv/powerlevel10k/blob/master/font.md#manual-font-installation)

## Customization

You can customize the script to suit your preferences, such as modifying the plugins or themes that are installed. Simply edit the `install_zsh.sh` script before running it.

## Tested Operating Systems

This script has been tested on the following operating systems:

- Ubuntu 24.04
- Kubuntu 24.04

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Chrysostomus/manjaro-zsh-config](https://github.com/Chrysostomus/manjaro-zsh-config) for the base configuration.
- Various Zsh plugins and themes that enhance the terminal experience.

## Contributing

If you find any issues or have suggestions for improvements, feel free to open an issue or submit a pull request.
