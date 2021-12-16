from flask import render_template
from flask import Flask
from markupsafe import escape
import socket
import datetime
import time

app = Flask(__name__)
@app.route('/hello/')
@app.route('/hello/<name>')
def hello(name=None):
    return render_template('hello.html', name=name)

@app.route('/easteregg')
def home():
   return "Wolfgang est passé ici!"

@app.route('/sleep/')
@app.route('/sleep/<secs>')
def sleep(secs=10):
    time.sleep(int(secs))
    return ("Useless activity done !")


@app.route('/buzy/')
@app.route('/buzy/<secs>')
def buzy(secs=10):
    timeout = time.time() + float(secs)  # X minutes from now
    print ("Current time is {}, waiting until {}".format( time.time(), timeout))
    while True:
        if time.time() > timeout:
            break
        10*10
    return ("Useless activity done !")

@app.route('/info')
def info():
    return socket.gethostname()

@app.route('/')
def template():
    return render_template('index.html', nowis=datetime.datetime.now().isoformat(),host=socket.gethostname())
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=80)

