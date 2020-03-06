# Docker LAMP stack (Laravel/Symfony ready)

Depending on your app structure, you may need to modify the default volumes declared in the `php` and `apache` services in the `docker-compose.yml` file. 

The current mapping points to a test file simply displaying a `phpinfo()` in order to check if the services are running as expected.

## Launch the server
```bash
docker-compose up -d --build
```

Then the server will be accessible at the url:
```
http://localhost
```

If everything is fine, your browser should display a `phpinfo()` page.

## Activate HTTPS (self-signed)

A self-signed certificate is available in the directory `./apache/ssl`.

To activate it, you just have to uncomment the 2nd vhost of the file `./apache/app-vhosts.conf` and rebuild the `apache` service with:
```
docker-compose up -d --build
```

## Development environment
A few modifications need to be done regarding the `php` service:
- `./php/Dockerfile`: 
    - Uncomment the lines related to the xDebug installation
    - Comment the line loading the production `php.ini` file
    - Uncomment the line loading the development `php.ini` file
- `./docker-compose.yml`:
    - `php` service: uncomment the environment variables declaration
- Rebuild the `php` service with:
```
docker-compose up -d --build
```

## Node.js service

This service is here because I personaly use `Gulp` to compile assets.

So if you have a `package.json` and a `gulpfile.js` file at the root of your project, everything is ready to execute your Gulp tasks.

You can simply do something like this :
```
> docker exec -it node npm i
> docker exec -it node ./node_modules/.bin/gulp
```

## PHPStorm configuration for xDebug

You can find the xDebug configuration in the file `./php/ini/xdebug.ini`.

If you have followed the step to activate the development environment, this configuration file will be automatically loaded.

The port setup for the communication with xDebug is `9000` (it is the default port).

- So in the PHPStorm configuration interface go to `Languages & Frameworks > PHP > Debug` and make sure that the debug port is set to `9000`.
- Start listening for PHP debug connections.
- Put a breakpoint where you want.

It should work.

## CLI debugging

2 values may need to be changed:
- In the `./php/ini/xdebug.ini` file:
    - `xdebug.remote_host=172.17.0.1`. It is already set to the default IP given by Docker to your Docker network interface. You just have to make sure that this IP is the good one (simply use the `ifconfig` command to check that).
- `docker-compose.yml`:
    - `PHP_IDE_CONFIG="serverName=localhost"`. This is the name of the debug server in your PHPStorm config (`Languages & Frameworks > PHP > Servers > Name`). If you are using the `localhost` domain name to reach your local app, this value will be the default one given by PHPStorm. Otherwise, if you use another domain name, it will be used to name your debug server inside PHPStorm.
