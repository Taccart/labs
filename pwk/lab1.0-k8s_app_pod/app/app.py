from flask import render_template
from flask import Flask
from markupsafe import escape
import socket
import datetime


app = Flask(__name__)
@app.route('/hello/')
@app.route('/hello/<name>')
def hello(name=None):
    return render_template('hello.html', name=name)

@app.route('/easteregg')
def home():
   return "Wolfgang est passé ici!"

@app.route('/info')
def info():
    return socket.gethostname()
@app.route('/')
def template():
    return render_template('index.html', nowis=datetime.datetime.now().isoformat())
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=80)

