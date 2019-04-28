# truffle：
以太坊adpp开发框架
http://truffle.tryblockchain.org/index.html
https://truffleframework.com/docs/truffle/overview

# ganache:
https://truffleframework.com/ganache
快速启动个人以太坊区块链，您可以使用它来运行测试，执行命令和检查状态，同时控制链的运行方式。
每次打开都是从0开始，数据存储在内存中
truffle连接到ganache，就能进行本地测试

# 安装truffle
npm install truffle -g 
环境必须是Node v8.9.4以上

# unbox
Truffle 的盒子Boxs装有很多非常实用的项目样板，可以让你忽略一些环境配置问题，从而可以集中与开发你自己的DApp的业务唯一性。除此之外，Truffle Boxes能够容纳其他有用的组件、Solidity合约或者库，前后端视图等等。所有这些都是一个完整的实例Dapp程序。都可以下载下来逐一研究，寻找适合自己公司目前业务模型的组件。
truffle unbox pet-shop 下载一个项目样板

# 也可以 init 全新的
```truffle init```
contracts/：Solidity合约目录
migrations/：部署合约脚本目录
test/：测试用例
truffle-config.js：配置文件
build/合约编译```truffle compile```后自动生成目录

# 本地部署
1、启动ganache
2、truffle-config配置如下文件
https://truffleframework.com/docs/truffle/reference/configuration
```bash
module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*" // Match any network id
    }
  }
};
```
3、部署脚本migrations
```bash
var Adoption = artifacts.require("Adoption");

module.exports = function (deployer) {
    // deployment steps
    deployer.deploy(Adoption);
};
```
4、终端```truffle migrate```命令部署
5、ganache看到blcoks区块交易信息证明成功了

# 测试用例
测试用例可以用javasrcipt或者solidity编写，案例
https://truffleframework.com/docs/truffle/testing/writing-tests-in-solidity

# web环境
npm init
npm install lite-server
创建 bs-config.json 告诉server到哪里找文件
在package.json加入，运行脚本是，启动server
```bash
"scripts": {
    "dev":"lite-server",
    "test": "echo \"Error: no test specified\" && exit 1"
  },
```
添加src目录，编写index.html
启动npm run dev

# UI如何与智能合约交互介绍
web3.js 
https://web3js.readthedocs.io/en/1.0/#
http://web3.tryblockchain.org/
https://learnblockchain.cn/docs/web3js-0.2x/index.html

truffle-contract.js 
与web3.js一样，都是用来与以太坊智能合约交互的JS库
https://github.com/trufflesuite/truffle-contract