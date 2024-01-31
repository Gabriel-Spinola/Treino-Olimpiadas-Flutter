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
    res = supabase_client.table(TABLE_NAME).select('*').execute().model_dump()

    return jsonify(res), 200
  except Exception as error:
    return f'Failed to fetch avocados\n{error}', 500

@app.get('/avocado/<string:id>')
def get_avocado_by_id(id: str):
  try: 
    res = supabase_client\
      .table(TABLE_NAME)\
      .select('*')\
      .eq('id', id)\
      .execute()\
      .model_dump()

    return jsonify(res), 200
  except Exception as error:
    return f'Failed fetch avocado with id: {id}\n{error}', 500

@app.post('/avocado/')
def upsert_avocado():
  try:
    json_res = request.get_json()
    avocado = Avocado(name=json_res['name'], amount=json_res['amount'], price=json_res['price'])
    res = supabase_client.table(TABLE_NAME).insert([avocado.__dict__]).execute()

    return jsonify(res), 201
  except Exception as error:
    return f'Failed to create new avocado item\n{error}', 500

@app.delete('/avocado/<string:id>')
def delete_avocado(id: str):
  try:
    res = supabase_client\
      .table(TABLE_NAME)\
      .delete()\
      .eq('id', id)\
      .execute()\
      .model_dump()
    
    return jsonify(res), 204
  except Exception as error:
    return f'Failed to create new avocado item\n{error}', 500

# @app.put('/avocado/<string:id>')
# def upsert_avocado(id: str):
#   try:
#     json_res = request.get_json()
#     avocado = Avocado(name=json_res['name'], amount=json_res['amount'], price=json_res['price'])

#     res = supabase_client\
#       .table(TABLE_NAME)\
#       .upsert([avocado.__dict__])\
#       .eq('id', id)\
#       .execute()

#     return jsonify(res), 201
#   except Exception as error:
#     return f'Failed to upsert avocado item {id}\n{error}', 500
