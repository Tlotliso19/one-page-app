from flask import Flask, render_template, jsonify
import pandas as pd

app = Flask(__name__)

@app.route('/')
def index():
    # Create a simple DataFrame for demonstration
    data = pd.read_csv('files/product.csv')
    df = pd.DataFrame(data)
    columns = df.columns.tolist()


    # Convert the DataFrame to JSON
    df_json = df.to_dict(orient='records')  # This will convert the DataFrame to a list of dictionaries
    return render_template('index.html', data=df_json,columns=columns)

@app.route('/data')
def data():
    # Same data as before, but serving it via an API route
    data = pd.read_csv('files/product.csv')
    df = pd.DataFrame(data)

    # Convert to JSON and send back
     # Convert DataFrame to a list of records (dictionaries)
    df_json = df.to_dict(orient='records') 
    #df_json = df.to_json(orient='records')
    return jsonify(df_json)

if __name__ == "__main__":
    app.run(debug=True)
