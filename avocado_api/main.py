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

@app.get("/ping/")
def ping():
  return 'pong', 200

@app.get("/avocado/")
def get_avocados():
  try: 
    res = supabase_client.table(TABLE_NAME).select('*').execute()

    return jsonify(res), 200
  except:
    return 'Failed to fetch avocados', 500


@app.get('/avocado/<int:id>')
def get_avocado_by_id(avocado_id: int):
  try: 
    res = supabase_client.table(TABLE_NAME).select(avocado_id).execute()

    return jsonify(res), 200
  except:
    return f'Failed fetch avocado with id: {id}', 500

@app.post('/avocado/')
def add_avocado():
  try:
    res = request.get_json()

    avocado = Avocado(name=res['name'], amount=res['amount'], price=res['price'])

    return , 201
  except:
    return 'Failed to create new avocado item', 500