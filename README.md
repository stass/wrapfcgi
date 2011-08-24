WRAPFCGI
========

This script allows one to run FastCGI unaware scripts as FastCGI applications.
The script will execute the script provided each time the FastCGI request is made,
transmitting its output as a result.

This can be useful when you need to run a CGI script under HTTP servers without
CGI support (for example, Nginx).

Example
-------

`spawn-fcgi -a 127.0.0.1 -p 9999 -- ~/path/to/wrapfcgi.rb /home/www/htdocs/dspam/cgi-bin/admingraph.sh`
will run DSPAM administrative statistics CGI application under the FastCGI server on port 9999, so
it is can be accessed by Nginx.
