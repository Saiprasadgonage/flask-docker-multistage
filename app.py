from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello world"

@app.route('/about')
def about():
    return "This is a simple Flask app running in Docker."

@app.route('/status')
def status():
    return jsonify({
        'status': 'running',
        'version': '1.0.0',
        'message': 'Flask app is healthy!'
    })

@app.route('/greet/<name>')
def greet(name):
    return f"Hello, {name.capitalize()}! Welcome to the Flask Docker app."

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
