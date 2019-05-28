#!/usr/bin/env bash
# --
# Author
# --
# Iván Jaimes <ivan@iver.mx>
#
# Goal script:  set color environment variables.

set -o errexit
set -o nounset

. env

pcolor "INFO" "Saludos terricola!! INFO";

pcolor "WARNING" "Saludos terricola!! WARN";

pcolor "ERROR" "Saludos terricola!! ERROR";

pcolor "Desde juera";

pcolor "DEBUG" "Desde juera";
