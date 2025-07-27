from flask import Flask, Response

app = Flask(__name__)

@app.route('/')
def fallback():
    return Response("Not authorized or not found.", status=404)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=4444)
