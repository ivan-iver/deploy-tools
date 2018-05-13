 --
 # (c) Iver!
 # Iván Jaimes <ivan.iver@gmail.com>

 echo "Request letsencrypt certificate "

 export DOMAINS="example.mx"
 export DIR=/var/www/letsencrypt

 letsencrypt certonly -a webroot --webroot-path=$DIR -d $DOMAINS

 echo "Done!"
