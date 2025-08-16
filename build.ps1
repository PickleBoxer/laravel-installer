# Build script for Laravel Installer Docker image (PowerShell)

param(
    [Parameter(Mandatory=$false)]
    [string]$DockerHubUsername = "pickleboxer"
)

# Set variables
$ImageName = "${DockerHubUsername}/laravel-installer"
$Tag = "latest"

Write-Host "Building Docker image: ${ImageName}:${Tag}" -ForegroundColor Blue

# Build the image
docker build -t "${ImageName}:${Tag}" .

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Build successful!" -ForegroundColor Green
    Write-Host ""
    Write-Host "To test the image:" -ForegroundColor Yellow
    Write-Host "docker run --rm ${ImageName}:${Tag} --version" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "To push to Docker Hub:" -ForegroundColor Yellow
    Write-Host "docker push ${ImageName}:${Tag}" -ForegroundColor Cyan
} else {
    Write-Host "❌ Build failed!" -ForegroundColor Red
    exit 1
}
