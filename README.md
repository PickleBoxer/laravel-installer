# Laravel Installer

![Build](https://github.com/PickleBoxer/laravel-installer/workflows/Build%20and%20Push%20Docker%20Images/badge.svg)

Docker image for Laravel Installer. Create Laravel projects without local PHP or Composer installation.

## Quick Start

### Linux / macOS / Git Bash

```bash
# Using latest Laravel installer version
docker run --rm -v $PWD:/opt pickleboxer/laravel-installer new PROJECT_NAME

# Using specific Laravel installer version
docker run --rm -v $PWD:/opt pickleboxer/laravel-installer:5.22.0 new PROJECT_NAME
```

### PowerShell / Windows

```powershell
# Using latest Laravel installer version
docker run --rm -v ${PWD}:/opt pickleboxer/laravel-installer new PROJECT_NAME

# Using specific Laravel installer version
docker run --rm -v ${PWD}:/opt pickleboxer/laravel-installer:5.22.0 new PROJECT_NAME
```

## Usage Examples

### Interactive Mode (Recommended)

Run without project name to get interactive prompts for starter kits, testing frameworks, and more:

**Linux / macOS / Git Bash:**
```bash
docker run --rm -it -v $PWD:/opt pickleboxer/laravel-installer new
```

**PowerShell / Windows:**
```powershell
docker run --rm -it -v ${PWD}:/opt pickleboxer/laravel-installer new
```

The installer will ask you:
- Project name
- Starter kit (Breeze, Jetstream, or none)
- Testing framework (Pest or PHPUnit)
- Database configuration
- Git repository initialization

### Create a new Laravel project (non-interactive)

**Linux / macOS / Git Bash:**
```bash
docker run --rm -v $PWD:/opt pickleboxer/laravel-installer new blog
```

**PowerShell / Windows:**
```powershell
docker run --rm -v ${PWD}:/opt pickleboxer/laravel-installer new blog
```

### Run with correct file permissions (Linux/macOS)

```bash
docker run --rm -it \
  -v $PWD:/opt \
  -u $(id -u):$(id -g) \
  pickleboxer/laravel-installer new
```

### Use specific installer version

**Linux / macOS / Git Bash:**
```bash
docker run --rm -it -v $PWD:/opt pickleboxer/laravel-installer:5.21.0 new
```

**PowerShell / Windows:**
```powershell
docker run --rm -it -v ${PWD}:/opt pickleboxer/laravel-installer:5.21.0 new
```

## Available Tags

This repository automatically maintains Docker images for the last 5 stable Laravel Installer versions:

- `latest` - Latest Laravel Installer version (currently 5.23.1)
- `5.23.1` - Laravel Installer v5.23.1
- `5.22.0` - Laravel Installer v5.22.0
- `5.21.0` - Laravel Installer v5.21.0
- `5.20.0` - Laravel Installer v5.20.0
- `5.19.0` - Laravel Installer v5.19.0

**Note:** Images are automatically built weekly to track new Laravel Installer releases.

## Version Numbering

Images are tagged with Laravel Installer version numbers (e.g., `5.23.1`), following the official [laravel/installer](https://packagist.org/packages/laravel/installer) package versions.

## Local Development

### Build locally

```bash
# Build with latest version
./build.sh

# Build with specific version
./build.sh --version 5.22.0

# Build with custom Docker Hub username
./build.sh --version 5.22.0 --username yourusername
```

### PowerShell (Windows)

```powershell
# Build with latest version
.\build.ps1

# Build with specific version
.\build.ps1 -Version 5.22.0

# Build with custom username
.\build.ps1 -Version 5.22.0 -DockerHubUsername yourusername
```

## How It Works

- Base image: Official Composer 2.x image
- Laravel Installer: Installed globally via Composer
- Entrypoint: `laravel` command
- Working directory: `/opt` (mount your project directory here)

## Automated Updates

- **Weekly checks**: Automatically detects new Laravel Installer releases every Sunday
- **Version tracking**: Maintains `versions.json` with the last 5 stable versions
- **Auto-build**: Builds and pushes all tracked versions when updates are detected
- **Smoke testing**: Each image is tested before being pushed to Docker Hub

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open-source software licensed under the MIT license.
