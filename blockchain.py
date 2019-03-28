# {
# 	"index":0,
# 	"timestamp":"",
# 	"transactions":[
# 		{
# 			"sender":"",
# 			"recipient":"",
# 			"amount":5
# 		}
# 	],
# 	"proof":"",
# 	"previus_hash":"",
# }
#
# chain：链结构信息，数组
# current_transactions :当前的交易信息
# new_block方法：新的快
# new_transactions方法：新的交易
# hash静态方法：计算区块的hash
# last_block方法:当前区块中最后一个块
# sender：发送者
# recipient:接收者
# amount：金额
# proof：工作量
# previus_hash：最后一个hash

from time import time
import hashlib
import json
from flask import Flask
from flask import jsonify
from flask import request
import uuid
from urllib.parse import urlparse
import requests
from argparse import ArgumentParser


class Blcokchain:
    def __init__(self):
        self.chain = []
        self.current_transactions = []
        self.nodes = set()

        # 创世纪区块
        self.new_block(proof=100, previus_hash=1)

    # 注册节点
    def register_node(self, address: str):
        # http://127.0.0.1:5001/ -》 127.0.0.1:5001
        parsed_url = urlparse(address)
        self.nodes.add(parsed_url.netloc)

    # 验证节点的有效性
    def valid_chain(self, chain) -> bool:
        last_block = chain[0]
        current_index = 1
        while current_index < len(chain):
            blcok = chain[current_index]

            if blcok['previus_hash'] != self.hash(last_block):
                return False

            if not self.valid_proof(last_block['proof'], blcok['proof']):
                return False

            last_block = blcok
            current_index += 1

        return True

    # 共识机制,解决冲突
    def resolve_conflicts(self):

        neighbours = self.nodes

        max_length = len(self.chain)
        new_chain = None

        for node in neighbours:
            reponse = requests.get('http://{}/chain'.format(node))
            if reponse.status_code == 200:
                length = reponse.json()['length']
                chain = reponse.json()['chain']

                if length > max_length and self.valid_chain(chain):
                    max_length = length
                    new_chain = chain

        if new_chain:
            self.chain = new_chain
            return True

        return False

    def new_block(self, proof, previus_hash=None):
        block = {
            "index": len(self.chain) + 1,
            "timestamp": time(),
            "transactions": self.current_transactions,
            "proof": proof,
            "previus_hash": previus_hash or self.hash(self.last_block)
        }

        self.current_transactions = []
        self.chain.append(block)
        return block

    def new_transaction(self, sender, recipient, amount) -> int:
        self.current_transactions.append(
            {
                "sender": sender,
                "recipient": recipient,
                "amount": amount
            }
        )

        return self.last_block['index'] + 1

    @staticmethod
    def hash(block):
        block_string = json.dumps(block, sort_keys=True).encode()
        return hashlib.sha256(block_string).hexdigest()

    # 最后一个区块
    @property
    def last_block(self):
        return self.chain[-1]

    # 工作量證明
    def proof_of_work(self, last_proof: int) -> int:
        proof = 0
        while self.valid_proof(last_proof, proof) is False:
            proof += 1
        # print(proof)
        return proof

    # 工作量驗證
    def valid_proof(self, last_proof, proof) -> bool:
        guess = '{}{}'.format(last_proof, proof).encode()
        guess_hash = hashlib.sha256(guess).hexdigest()
        print(guess_hash)

        if guess_hash[0:4] == "0000":
            return True
        else:
            return False


app = Flask(__name__)
blcokchain = Blcokchain()
node_id = str(uuid.uuid4()).replace('-', '')


# http://127.0.0.1:5000/index
@app.route('/index', methods=['GET'])
def index():
    return "hello blockchain"


@app.route('/transaction/new', methods=['POST'])
def new_transaction():
    values = request.get_json(force=True)
    required = ["sender", "recipient", "amount"]
    if values is None:
        return "missing vlaues", 400
    if not all(k in values for k in required):
        return "missing vlaues", 400

    index = blcokchain.new_transaction(values['sender'], values['recipient'], values['amount'])
    respones = {"message": "transaction will be added to block {}".format(index)}
    return jsonify(respones), 201


@app.route('/mine', methods=['GET'])
def mine():
    last_block = blcokchain.last_block
    last_block_proof = last_block['proof']
    proof = blcokchain.proof_of_work(last_block_proof)
    blcokchain.new_transaction(sender="0", recipient=node_id, amount=1)
    blcok = blcokchain.new_block(proof, None)
    respones = {
        "message": "new block forged",
        "index": blcok['index'],
        "transaction": blcok['transactions'],
        "proof": blcok['proof'],
        "previus_hash": blcok['previus_hash']
    }
    return jsonify(respones), 200


@app.route('/chain', methods=['GET'])
def full_chain():
    respones = {
        'chain': blcokchain.chain,
        'length': len(blcokchain.chain)
    }
    return jsonify(respones), 200


# {"nodes":["http://127.0.0.1:5001"]}
# 用户注冊节点
@app.route('/nodes/register', methods=['POST'])
def register_nodes():
    values = request.get_json(force=True)
    nodes = values.get("nodes")

    if nodes is None:
        return "Error:please supply a valid list of nodes", 400

    for node in nodes:
        blcokchain.register_node(node)

    respones = {
        "message": "New nodes have benn added",
        "total_nodes": list(blcokchain.nodes)
    }

    return jsonify(respones), 201


# 调用解决冲突
@app.route('/nodes/resolve', methods=['GET'])
def consensus():
    replaced = blcokchain.resolve_conflicts()

    if replaced:
        respones = {
            'message': "our chain was replacd",
            "new_chain": blcokchain.chain
        }
    else:
        respones = {
            'message': "our chain was authoritative",
            "chain": blcokchain.chain
        }

    return jsonify(respones), 200


# if __name__ == '__main__':
#     testpow = Blcokchain()
#     testpow.proof_of_work(100)


if __name__ == '__main__':
    parser = ArgumentParser()
    # -p --port 5001
    parser.add_argument('-p', '--port', default=5001, type=int, help='port to listen to')
    args = parser.parse_args()
    port = args.port
    app.run(host='0.0.0.0', port=port)
