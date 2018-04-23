#!/usr/bin/bash
mkdir -p $1/app/templates $1/app/ext $1/app/models $1/app/static $1/app/views
touch $1/manage.py $1/app/setting.py $1/app/debug.py $1/app/__init__.py $1/app/ext/__init__.py $1/app/models/__init__.py $1/requirements.txt

echo 'from flask import Flask
from app.views import *


def create_app(debug=True):
    app = Flask(__name__)
    app.config.from_pyfile("setting.py")
    if debug:
        app.config.from_pyfile("debug.py")
#    configure_logging(app)
#    configure_extension(app)
#    configure_blueprint(app)

    return app
' >> $1/app/__init__.py

echo "import os

SECRET_KEY = 'super secret key'
#SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://user:password@ip:port/db'
#SQLALCHEMY_TRACK_MODIFICATIONS = True
" >> $1/app/setting.py

echo 'from flask_sqlalchemy import SQLAlchemy
import logging

db = SQLAlchemy()
logger = logging.getLogger(__name__)
' >> $1/app/ext/__init__.py

echo 'from flask_script import Server, Manager, prompt, prompt_bool
from app import create_app
from app.ext import *
from app.models import *


app = create_app(debug=True)
manager = Manager(app)
manager.add_command("runserver", Server(host="0.0.0.0", port=5000))

@manager.command
def create_db():
    db.create_all()

if __name__ == "__main__":
    manager.run()
' >> $1/manage.py

echo 'Flask
Flask-SQLAlchemy
Flask-Script
pymysql
ipython
' >> $1/requirements.txt

cd $1
pipenv --three
pipenv install
cd ..
