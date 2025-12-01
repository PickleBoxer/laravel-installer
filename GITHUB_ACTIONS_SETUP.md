# GitHub Actions Setup Guide

## Initial Setup

### 1. Create Docker Hub Repository

Create a public repository on Docker Hub named `laravel-installer`.

### 2. Configure GitHub Secrets

Add the following secrets to your GitHub repository settings:

- `DOCKER_USERNAME` - Your Docker Hub username
- `DOCKER_PASSWORD` - Your Docker Hub access token (recommended) or password

**How to add secrets:**
1. Go to your GitHub repository
2. Click on **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Add each secret with the corresponding value

### 3. Bootstrap Version File

The repository includes `versions.json` with the last 5 stable Laravel Installer versions. This file is automatically maintained by the update workflow.

### 4. Push to GitHub

Push your changes to the `main` branch to trigger the first build.

## Automated Workflows

### Version Update Workflow (`update-versions.yml`)

**Purpose:** Automatically detects and tracks new Laravel Installer releases.

**Triggers:**
- **Scheduled:** Every Sunday at 00:00 UTC
- **Manual:** Via workflow dispatch in GitHub Actions UI

**What it does:**
1. Fetches available versions from Packagist API
2. Extracts the last 5 stable versions (excludes dev branches)
3. Updates `versions.json` if changes detected
4. Commits and pushes the updated file
5. Triggers the Docker build workflow automatically

**Manual trigger:**
1. Go to **Actions** → **Update Laravel Installer Versions**
2. Click **Run workflow** → **Run workflow**

### Docker Build Workflow (`docker.yml`)

**Purpose:** Builds and pushes Docker images for all tracked Laravel Installer versions.

**Triggers:**
- **Automatic:** When `versions.json`, `Dockerfile`, or the workflow file changes
- **Manual:** Via workflow dispatch in GitHub Actions UI

**What it does:**
1. Reads versions from `versions.json`
2. Uses matrix strategy to build all 5 versions in parallel
3. Applies OCI standard labels to each image
4. Runs smoke test (`laravel --version`) on each built image
5. Pushes images only if tests pass
6. Tags images with version numbers (e.g., `5.23.1`)
7. Tags the latest version as `latest`

**Matrix Build Benefits:**
- Parallel execution (faster builds)
- Independent version builds
- Isolated failures (one version failing doesn't affect others)

**Manual trigger:**
1. Go to **Actions** → **Build and Push Docker Images**
2. Click **Run workflow** → **Run workflow**

## Version Management

### Current Version Strategy

The repository maintains the **last 5 stable Laravel Installer versions** automatically:

- Versions are tracked in `versions.json`
- Updated weekly via automated workflow
- Images use Laravel Installer version tags (e.g., `5.23.1`)
- The `latest` tag always points to the highest version number

This follows Docker image tagging best practices.

## Image Tags

### Available Tags

Each version gets its own tag:
- `pickleboxer/laravel-installer:5.23.1`
- `pickleboxer/laravel-installer:5.22.0`
- `pickleboxer/laravel-installer:5.21.0`
- `pickleboxer/laravel-installer:5.20.0`
- `pickleboxer/laravel-installer:5.19.0`
- `pickleboxer/laravel-installer:latest` (points to 5.23.1)

### Tagging Strategy

- **Version-specific tags**: Never overwritten, permanent
- **`latest` tag**: Updated to point to the newest version
- **OCI labels**: Each image includes metadata (version, build date, source)

## Local Development

### Test Locally Before Pushing

```bash
# Build with specific version
./build.sh --version 5.22.0

# Or using PowerShell
.\build.ps1 -Version 5.22.0
```

The build scripts automatically run smoke tests after building.

### Manual Version Testing

```bash
# Test an image
docker run --rm pickleboxer/laravel-installer:5.22.0 --version

# Create a test project
docker run --rm -v $PWD:/opt pickleboxer/laravel-installer:5.22.0 new test-project
```

## Troubleshooting

### Build Failures

**Symptom:** Build workflow fails for specific version

**Solutions:**
1. Check if the Laravel Installer version exists on Packagist
2. Verify `versions.json` contains valid version numbers
3. Check build logs for specific error messages
4. Test locally with `./build.sh --version VERSION`

### Smoke Test Failures

**Symptom:** Build succeeds but smoke test fails

**Solutions:**
1. The Laravel Installer version might have issues
2. Check if Composer can resolve dependencies
3. Test the version locally before pushing
4. Remove the problematic version from `versions.json`

### Version Update Not Triggering

**Symptom:** New Laravel Installer released but not built

**Solutions:**
1. Check last run of update-versions workflow
2. Manually trigger update-versions workflow
3. Verify `versions.json` was updated
4. Check if docker workflow was triggered after update

### Permission Issues

**Symptom:** Workflow can't push to repository

**Solutions:**
1. Ensure workflow has `contents: write` permission
2. Check repository settings → Actions → General → Workflow permissions
3. Set to "Read and write permissions"

## Best Practices

### Regular Maintenance

- **Monitor weekly runs**: Check that version updates run successfully
- **Review build logs**: Ensure all versions build and test properly
- **Update documentation**: Keep README in sync with available versions
- **Clean old images**: Periodically review and remove unused tags

### Security

- **Use access tokens**: Use Docker Hub access tokens instead of passwords
- **Rotate secrets**: Regularly rotate Docker Hub tokens
- **Review permissions**: Ensure workflows have minimal required permissions
- **Monitor alerts**: Enable GitHub security alerts for the repository

### Versioning

- **Don't manually edit versions.json**: Let the automation handle it
- **Pin base images**: The Dockerfile uses `composer:2` for stability
- **Test before release**: Always test images locally when possible
- **Document changes**: Update CHANGELOG when making significant changes

## Advanced Configuration

### Change Number of Tracked Versions

To track more or fewer versions, edit `.github/workflows/update-versions.yml`:

```yaml
# Change .[0:5] to .[0:N] where N is desired count
| .[0:10]  # Track last 10 versions
```

### Add Custom Tags

To add additional custom tags, modify `.github/workflows/docker.yml`:

```yaml
tags: |
  type=raw,value=${{ matrix.version }}
  type=raw,value=latest,enable=${{ matrix.version == needs.prepare.outputs.latest_version }}
  type=raw,value=stable  # Add custom tag
```

### Change Update Frequency

To change how often versions are checked, edit the cron schedule:

```yaml
schedule:
  # Daily at midnight
  - cron: '0 0 * * *'
  
  # Every Monday at 6 AM
  - cron: '0 6 * * 1'
```

## Support

For issues or questions:
- **GitHub Issues**: https://github.com/PickleBoxer/laravel-installer/issues
- **Docker Hub**: https://hub.docker.com/r/pickleboxer/laravel-installer
- **Laravel Installer**: https://github.com/laravel/installer
