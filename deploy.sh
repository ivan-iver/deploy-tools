#!/bin/bash

# Copyright (c) 2016 Iván Jaimes, https://iver.mx. See LICENSE file.
#
# This is a skeleton of a bash deploy script and is part of a scripts collection.
# If you wish to know more about it please visit https://github.com/ivan-iver/deploy-tools
# To use for yourself, just set the scripts variables and then run it.

export API_PACKAGE=pack.tar.gz
export TARGET=server
export DEPLOY_PATH=/var/www/
export OWNER=iver
export WEB_USER=www-data

if [ ! -f $API_PACKAGE ]; then
  echo "Package file is not ready. Please run make package"
  exit 0;
fi

echo "Uploading files ...";
scp $API_PACKAGE $TARGET:/tmp


ssh -t $TARGET "
  rm -r $DEPLOY_PATH/htdocs &&
  tar -xvzf /tmp/$API_PACKAGE -C $DEPLOY_PATH;
  sudo find $DEPLOY_PATH/ -type d -exec chmod 755 {} \;
  sudo find $DEPLOY_PATH/ -type f -exec chmod 644 {} \;
  sudo chown $OWNER:$WEB_USER $DEPLOY_PATH/htdocs;
";

echo "Deleting zip...";
rm $API_PACKAGE;
echo "Done!";

