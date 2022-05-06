import click
from flask import Flask, render_template

app = Flask(__name__)


@app.route('/')
def index():
    airbus_division = ["commercials", "Defence and Space", "Helicopters"]
    return render_template('index.html', divisions = airbus_division)

@app.cli.command()
def hello():
    """Just say hello."""
    click.echo('Hello, Human!')
