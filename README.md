# Docker LAMP stack (+ PHPStorm xDebug configuration)

Depending on your app structure, you may need to modify the default vhost.

## Launch the server
```bash
sudo docker-compose up -d --build
```

Then the server will be accessible at the url:
```
http://localhost:8001
```

If everything is fine, your browser should display the success message `It works!`.

## PHPStorm configuration for xDebug

At the end of the file `php/php.ini`, you will find the xDebug configuration.

The port setup for the communication with xDebug is 9001 here.

- So in the PHPStorm configuration interface go to `Languages & Frameworks > PHP > Debug` and set the debug port to 9001.
- Then go to `Languages & Frameworks > PHP > Debug > DBGp Proxy`, set:
  - IDE Key to `PHPSTORM`
  - Host to the IP address of your docker network interface (use `ifconfig` to get this info)
  - Port to `9001`
- Start listening for PHP debug connections.

It should work.

## Troubleshooting

### Apache not starting

Sometimes the `apache_web` service may not start saying something like this: `httpd is already running`. To fix this you will have to rebuild and restart this container:

```bash
docker-compose stop apache_web
docker-compose build apache_web
docker-compose up -d --no-deps apache_web
``` 

### PHP7 extension directory

If using PHP 7+, you may need to update the `extension_dir` value in your `php.ini` file.

I had to change from:
```
extension_dir = "/usr/lib/php/20131226"
```
to:
```
extension_dir = "/usr/lib/php/20160303"
```

