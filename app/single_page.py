from flask import Flask, render_template,send_from_directory
import os



app = Flask(__name__)

@app.route("/")
def hello_world():
    return render_template("index.html")


if __name__ == '__single_page__':
    app.run(debug=True)

