from flask import Flask
import os

app = Flask(__name__)


@app.route('/postreceive_backend', methods=['POST'])
def back():
    os.system("./candy-server-spring.sh")
    return 'Success!'


if __name__ == "__main__":
    app.run()
