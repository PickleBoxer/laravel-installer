# Build script for Laravel Installer Docker image (PowerShell)

param(
    [Parameter(Mandatory=$false)]
    [string]$Version = "latest",
    
    [Parameter(Mandatory=$false)]
    [string]$DockerHubUsername = $env:DOCKER_USERNAME
)

# Set default username if not provided
if (-not $DockerHubUsername) {
    $DockerHubUsername = "pickleboxer"
}

# Set variables
$InstallerVersion = $Version
$ImageName = "${DockerHubUsername}/laravel-installer"
$Tag = $InstallerVersion

Write-Host "Building Docker image: ${ImageName}:${Tag}" -ForegroundColor Blue
Write-Host "Laravel Installer version: ${InstallerVersion}" -ForegroundColor Blue
Write-Host ""

# Build the image
docker build `
    --build-arg INSTALLER_VERSION="$InstallerVersion" `
    -t "${ImageName}:${Tag}" `
    .

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✅ Build successful!" -ForegroundColor Green
    Write-Host ""
    
    # Run smoke test
    Write-Host "Running smoke test..." -ForegroundColor Yellow
    docker run --rm "${ImageName}:${Tag}" --version
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✅ Smoke test passed!" -ForegroundColor Green
        Write-Host ""
        Write-Host "To push to Docker Hub:" -ForegroundColor Yellow
        Write-Host "docker push ${ImageName}:${Tag}" -ForegroundColor Cyan
    } else {
        Write-Host ""
        Write-Host "❌ Smoke test failed!" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host ""
    Write-Host "❌ Build failed!" -ForegroundColor Red
    exit 1
}
