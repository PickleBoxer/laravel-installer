# Laravel installer

![Build](https://github.com/PickleBoxer/laravel-installer/workflows/Build/badge.svg)

Docker image with Laravel installer. No need to manage local PHP or Composer.

## Usage

```bash
# Latest Composer version
docker run --rm -v $PWD:/opt pickleboxer/laravel-installer new PROJECT_NAME

# Specific Composer version
docker run --rm -v $PWD:/opt pickleboxer/laravel-installer:2.7 new PROJECT_NAME
```

## Examples

```bash
# New Laravel project
docker run --rm -v $PWD:/opt pickleboxer/laravel-installer new blog

# Run as current user for correct filesystem permissions
docker run --rm \
  -v $PWD:/opt \
  -u $(id -u):$(id -g) \
  pickleboxer/laravel-installer:latest new api
```

## Available Tags

- `latest` - Latest Composer version
- `2.8` - Composer 2.8
- `2.7` - Composer 2.7
