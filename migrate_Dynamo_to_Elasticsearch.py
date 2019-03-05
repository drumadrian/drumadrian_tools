import boto3
import json
import decimal
from elasticsearch import Elasticsearch
from boto3.dynamodb.conditions import Key, Attr

e_user = 'elastic'
e_pw =  'fFOyYHX7GInbPT4HGX1R2Q8'
e_port = 9243
e_dsn = 'ba57da315775473196863345e227780.us-west-2.aws.found.io'

es_url =  "https://{}:{}@{}:{}".format(e_user, e_pw, e_dsn, e_port)
es_client = Elasticsearch(es_url, verify_certs=False)
es_client.indices.create(index='buttontable2', ignore=400)

class DecimalEncoder(json.JSONEncoder):
    def default(self, o):
        if isinstance(o, decimal.Decimal):
            if o % 1 > 0:
                return float(o)
            else:
                return int(o)
        return super(DecimalEncoder, self).default(o)


dynamodb = boto3.resource('dynamodb')

table = dynamodb.Table('buttontable2')

response = table.scan()

for i in response['Items']:
    print(i)
    es_client.index(index='buttontable2', doc_type="iot", body=i)

while 'LastEvaluatedKey' in response:
    response = table.scan(
	   ExclusiveStartKey=response['LastEvaluatedKey']
        )

    for i in response['Items']:
        print(json.dumps(i, cls=DecimalEncoder))
