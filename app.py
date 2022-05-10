from flask import Flask, render_template
import os

app = Flask(__name__)


@app.route('/')
def index():
    airbus_division = ["commercials", "Defence and Space", "Helicopters", "Operations"]
    return render_template('index.html', divisions = airbus_division)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=os.environ['PORT'])