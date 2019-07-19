# docker-ttrss
Dockerized TinyTinyRSS with mod_mellon for remote auth

You have to provide a config.php with the following changes:

define('PLUGINS', 'auth_remote, note');
