import os
from supabase import create_client, Client 
from flask import Flask, jsonify, request
from dataclasses import dataclass

SUPABASE_URL: str = os.environ.get("SUPABASE_URL")
SUPABASE_KEY: str = os.environ.get("SUPABASE_KEY")
TABLE_NAME: str = 'AvocadoDB'

app = Flask(__name__)
app.config['DEBUG'] = True

supabase_client: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

@dataclass
class Avocado:
  name: str
  price: float
  amount: int

@app.get("/avocado/")
def get_avocados():
  try: 
    res = supabase_client.table(TABLE_NAME).select('*').execute()

    return jsonify(res), 200
  except:
    return 'Failed to fetch avocados', 300


@app.get('/avocado/<int:id>')
def get_avocado_by_id(avocado_id: int):
  try: 
    res = supabase_client.table(TABLE_NAME).select(avocado_id).execute()

    return jsonify(res), 200
  except:
    return f'Failed fetch avocado with id: {id}', 300

@app.post('/avocado/')
def add_avocado():
  try:
    print(request.get_json())

    return '', 204
  except:
    return '', 300