# PickleBoxer/laravel-installer

This Docker image allows you to run the Laravel installer without needing to have PHP, Composer, or the Laravel installer installed on your local machine. You can use this image to choose the Laravel starter kits and use Laravel Sail to start a new project.

## Usage

1. **Run the Laravel installer:**

    ```sh
    docker run --rm --interactive --tty \
      --volume $(pwd):/app \
      --user $(id -u):$(id -g) \
      pickleboxer/laravel-installer [project-name]
    ```

    Replace `[project-name]` with the desired name of your new Laravel project. If no name is provided, the default name `example-app` will be used.

2. **Navigate to the project directory:**

    ```sh
    cd [project-name]
    ```

3. **Start the Laravel Sail environment:**

    ```sh
    ./vendor/bin/sail up
    ```

4. **Run database migrations:**

    ```sh
    ./vendor/bin/sail php artisan migrate
    ```

## Example

```sh
# Run the Laravel installer to create a new project named "my-laravel-app"
docker run --rm --interactive --tty \
  --volume $(pwd):/app \
  --user $(id -u):$(id -g) \
  pickleboxer/laravel-installer my-laravel-app

# Navigate to the project directory
cd my-laravel-app

# Start the Laravel Sail environment
./vendor/bin/sail up

# Run database migrations
./vendor/bin/sail php artisan migrate