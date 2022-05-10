from flask import Flask, render_template

app = Flask(__name__)


@app.route('/')
def index():
    airbus_division = ["commercials", "Defence and Space", "Helicopters"]
    return render_template('index.html', divisions = airbus_division)

if __name == '__main__':
    app.run(debug=True, host='0.0.0.0')