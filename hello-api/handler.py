import json
import os

def hello(event, context):
    stage = os.environ.get('STAGE', 'default')  # Obtener el valor de la variable de entorno STAGE
    
    #hola mundo
    #body = {
    #    "message": f"Hola mundo :)"
    #}


    body = {
        "message": f"Hola, #CommunityDayGT! Saludos desde Lambda en el entorno < {stage} >"
    }

    response = {
        "statusCode": 200,
        "headers": {
            "Access-Control-Allow-Origin": "*",  # Habilitar CORS
            "Access-Control-Allow-Credentials": True
        },
        "body": json.dumps(body)
    }


    return response
