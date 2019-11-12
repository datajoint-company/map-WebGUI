#! /bin/sh
export FLASK_APP=./mapapi.py
[ "$1" = "development" ] && export FLASK_ENV=development
cd "`dirname $0`" && exec flask run -h 0.0.0.0
