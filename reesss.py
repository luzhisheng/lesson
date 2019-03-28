import requests

url = "http://10.0.0.178:5000/chain"

headers = {
    'Cache-Control': "no-cache",
    'Postman-Token': "bcdaed7e-a0dd-492c-ae18-4b89cbf9d6cf"
    }

response = requests.request("GET", url, headers=headers)

print(response.text)