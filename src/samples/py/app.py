from flask import Flask, request
from redis import Redis
from datetime import datetime
import socket

app = Flask(__name__)
redis = Redis(host='redis', port=6379)

@app.route('/')
def hello():
    redis.incr('hits')
    print request.__dict__
    return 'Hello %s, I am %s! <br /> Now is %s.<br /> I have been seen %s times.' % ( 
        request.remote_addr + ":" + str(request.environ['REMOTE_PORT']),
        socket.gethostbyname(socket.gethostname()) + ":" + str(request.environ['SERVER_PORT']),
        datetime.now().strftime("%A, %d. %B %Y %I:%M%p"),
        redis.get('hits')
    );

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True, port=5000)