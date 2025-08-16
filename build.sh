#!/bin/bash

# Build script for Laravel Installer Docker image

# Set variables
DOCKER_HUB_USERNAME="${1:-pickleboxer}"
IMAGE_NAME="${DOCKER_HUB_USERNAME}/laravel-installer"
TAG="latest"

echo "Building Docker image: ${IMAGE_NAME}:${TAG}"

# Build the image
docker build -t "${IMAGE_NAME}:${TAG}" .

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    echo ""
    echo "To test the image:"
    echo "docker run --rm \"${IMAGE_NAME}:${TAG}\" --version"
    echo ""
    echo "To push to Docker Hub:"
    echo "docker push ${IMAGE_NAME}:${TAG}"
else
    echo "❌ Build failed!"
    exit 1
fi
