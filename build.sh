#!/bin/bash

# Build script for Laravel Installer Docker image

# Default values
INSTALLER_VERSION="latest"
DOCKER_HUB_USERNAME="${DOCKER_USERNAME:-pickleboxer}"
IMAGE_NAME="${DOCKER_HUB_USERNAME}/laravel-installer"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --version)
            INSTALLER_VERSION="$2"
            shift 2
            ;;
        --username)
            DOCKER_HUB_USERNAME="$2"
            IMAGE_NAME="${DOCKER_HUB_USERNAME}/laravel-installer"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: $0 [--version VERSION] [--username USERNAME]"
            exit 1
            ;;
    esac
done

TAG="${INSTALLER_VERSION}"

echo "Building Docker image: ${IMAGE_NAME}:${TAG}"
echo "Laravel Installer version: ${INSTALLER_VERSION}"
echo ""

# Build the image
docker build \
    --build-arg INSTALLER_VERSION="${INSTALLER_VERSION}" \
    -t "${IMAGE_NAME}:${TAG}" \
    .

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Build successful!"
    echo ""
    
    # Run smoke test
    echo "Running smoke test..."
    if docker run --rm "${IMAGE_NAME}:${TAG}" --version; then
        echo ""
        echo "✅ Smoke test passed!"
        echo ""
        echo "To push to Docker Hub:"
        echo "docker push ${IMAGE_NAME}:${TAG}"
    else
        echo ""
        echo "❌ Smoke test failed!"
        exit 1
    fi
else
    echo ""
    echo "❌ Build failed!"
    exit 1
fi
