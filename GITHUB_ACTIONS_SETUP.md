# Setup

1. Create Docker Hub repo: `laravel-installer`
2. Add GitHub secrets:
   - `DOCKER_USERNAME`
   - `DOCKER_PASSWORD`
3. Update Composer version in `.env` file
4. Push to GitHub

## Version Management

- Edit `.env` to change Composer version
- Push to main → builds `latest` + `{composer-version}` tags
- Manual trigger → specify custom Composer version

## Example Tags

- `PickleBoxer/laravel-installer:latest`
- `PickleBoxer/laravel-installer:2.7`
