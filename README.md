# TinyTinyRSS
Dockerized TinyTinyRSS with mod_mellon and mod_ldap for remote auth

You have to provide a config.php with the following changes:

`define('PLUGINS', 'auth_remote, note');`

Also, you can enable simple update mode where tt-rss will try to periodically update feeds while it is open in your web browser. Obviously, no updates will happen when tt-rss is not open or your computer is not running.

To enable this mode, set constant `SIMPLE_UPDATE_MODE` to true in `config.php`.

Note that only main tt-rss UI supports this, if you have digest or mobile open or use an API client (for example, android application), feeds are not going to be updated. You absolutely have to have tt-rss open in a browser tab on a running computer somewhere.
