# app.py
from flask import Flask
from routes import genAI_routes

app = Flask(__name__)

# Register blueprints for each route group
app.register_blueprint(genAI_routes)

if __name__ == "__main__":
    # Run Flask app

    app.run(debug=True, port=5000)
