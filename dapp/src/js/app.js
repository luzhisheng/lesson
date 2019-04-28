App = {
  web3Provider: null,
  contracts: {},

  init: async function() {
    // Load pets.
    $.getJSON('../pets.json', function(data) {
      var petsRow = $('#petsRow');
      var petTemplate = $('#petTemplate');

      for (i = 0; i < data.length; i ++) {
        petTemplate.find('.panel-title').text(data[i].name);
        petTemplate.find('img').attr('src', data[i].picture);
        petTemplate.find('.pet-breed').text(data[i].breed);
        petTemplate.find('.pet-age').text(data[i].age);
        petTemplate.find('.pet-location').text(data[i].location);
        petTemplate.find('.btn-adopt').attr('data-id', data[i].id);

        petsRow.append(petTemplate.html());
      }
    });

    return await App.initWeb3();
  },

  initWeb3: async function() {
    //初始化web3
    if (typeof web3 !== 'undefined') {
      App.web3Provider = web3.currentProvider;
    } else {
      App.web3Provider = new Web3.prviders.WebsocketProvider("http://192.168.1.102:7545");
    }
    web3 = new Web3(App.web3Provider);
    console.log(web3)

    return App.initContract();
  },

  initContract: function() {
    //初始化智能合约
    //配置文件中引入了bs-config.json文件，所以能直接引用
    $.getJSON('Adoption.json', function (data) {
      var AdoptionArtifact = data;

      //初始化合约对象
      App.contracts.Adoption = TruffleContract(AdoptionArtifact);
      App.contracts.Adoption.setProvider(App.web3Provider);
      return App.markAdopted();
    })

    return App.bindEvents();
  },

  bindEvents: function() {
    $(document).on('click', '.btn-adopt', App.handleAdopt);
  },

  markAdopted: function(adopters, account) {
    //标记一个领养的状态
    //标记一个领养的状态:数组中下标为0的地址有非0的地址,就证明领养
    //then 然后

    var AdoptionInstance;
    App.contracts.Adoption.deployed().then(function(instance) {
      AdoptionInstance = instance;
      return AdoptionInstance.getAdopters.call();
    }).then(function (adopters) {
      for (i = 0; i < adopters.length; i++) {
        if (adopters[i] !== '0x0000000000000000000000000000000000000000'){
          //如果不是0，那么领养按钮是不能点击的
          $('.panel-pet').eq(i).find('button').text('Success').attr('disabled',true);
        }
      }
    }).catch(function(err) {
      console.log(err.message);
    })
  },

  handleAdopt: function(event) {
    //处理领养
    event.preventDefault();

    var petId = parseInt($(event.target).data('id'));
    console.log(petId)
    //只读属性，返回当前节点持有的帐户列表。
    console.log(web3.eth.accounts)
    web3.eth.getAccounts(function (error, resultAccounts) {
      console.log(resultAccounts)
      var AdoptionInstance;
      var account = resultAccounts[0];
      App.contracts.Adoption.deployed().then(function (instance) {
        AdoptionInstance = instance;
        return AdoptionInstance.adopt(petId, {from: account});
      }).then(function(result) {
        console.log(111)
        return App.markAdopted();
      }).catch(function (err) {
        console.log(err.message);
      });
    })
  }
};

$(function() {
  $(window).load(function() {
    App.init();
  });
});
