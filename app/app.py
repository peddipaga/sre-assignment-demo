from flask import Flask

app = Flask(__name__)

@app.get("/")
def hello():
    return "Hello, World!\n"

@app.get("/healthz")
def healthz():
    return "ok\n", 200

if __name__ == "__main__":
    # For local testing only. In k8s we run via gunicorn.
    app.run(host="0.0.0.0", port=8080)

# Test CI pipeline