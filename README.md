# Automatic package installer for Arch (based) Distros

This script automates the process of installing packages on an Arch Linux system using `pacman` and `yay`. It reads a list of packages from a `packages.txt` file, installs them based on whether they are managed by `pacman` or `yay`, and logs the results.

## Features

- **System Update**: Updates the system using `pacman -Syu`.
- **Package Installation**: Installs packages from `pacman` or `yay` based on the sections in the `packages.txt` file.
- **Logging**: Tracks which packages were successfully installed and which failed.
- **Clean-up**: Removes orphaned packages using `yay -Yc` and `pacman -Sc`.

## Requirements

- **Arch Linux** or an Arch-based distribution.
- **`yay`**: A popular AUR helper. It must be installed for handling AUR packages.
- **`pacman`**: The default package manager for Arch Linux.

To install `yay` on a fresh system:

```bash
sudo pacman -S yay
```

## Setup

1. **Download the Script**: Clone or download the script to your desired directory.

   ```bash
   git clone https://github.com/your-username/package-installer.git
   cd package-installer

2. **Create a**``packages.txt`` **file**: This file should contain a list of packages to install, separated into sections for pacman and yay.

Example ``packages.txt`` format:

```plaintext
# Packages for pacman
_pacman
package1
package2

# Packages for yay
_yay
yay-package1
yay-package2
```
- ``_pacman``: Marks the start of the pacman package section.
- ``_yay``: Marks the start of the yay package section.
Packages listed under ``_pacman`` will be installed via pacman, while packages listed under ``_yay`` will be installed via yay.
Comment lines (lines starting with ``#``) will be ignored.

3. Make the Script Executable:
```bash
chmod +x install_packages.sh
```
4. Run the Script:
```bash
./install_packages.sh
```
- The script will first update the system using pacman -Syu.
- It will then process the packages.txt file, installing the listed packages.
- Finally, it will log the results and clean up orphaned packages.

---

## Contributing

Feel free to fork this repository and submit pull requests with improvements or fixes. If you find bugs or have feature requests, please open an issue on GitHub.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
