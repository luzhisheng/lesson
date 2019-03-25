
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

from time import time
import hashlib
import json


class Blcokchain:

	def __init__(self):
		self.chain = []
		self.current_transactions = []

		# 创世纪区块
		self.new_block(proof=100, previus_hash=1)

	def new_block(self, proof, previus_hash = None):
		block = {
			"index": len(self.chain) + 1,
			"timestamp": time(),
			"transactions": self.current_transactions,
			"proof": proof,
			"previus_hash": previus_hash or self.hash(self.last_block)
		}

		self.current_transactions = []
		self.chain.append(block)

	def new_transaction(self, sender, recipient, amount) -> int:
		self.current_transactions.append(
			{
				"sender":sender,
				"recipient":recipient,
				"amount":amount
			}
		)

		return self.last_block['index'] + 1

	@staticmethod
	def hash(block):
		block_string = json.dumps(block, sort_keys=True).encode()
		return hashlib.sha256(block_string).hexdigest()

	@property
	def last_block(self):
		return self.chain[-1]

	# 工作量證明
	def proof_of_work(self, last_proof: int) -> int:
		proof = 0
		while self.valid_proof(last_proof, proof) is False:
			proof += 1
		print(proof)
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


if __name__ == '__main__':
	testpow = Blcokchain()
	testpow.proof_of_work(100)





