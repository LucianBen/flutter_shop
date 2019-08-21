const serviceUrl = 'http://v.jspang.com:8088/baixing/';
//const serviceUrl = 'https://www.easy-mock.com/mock/5d5173c75961736c0cc471c7/baixing/';
const servicePath = {
  'homePageContent': serviceUrl + 'wxmini/homePageContent', // 商店首页信息
  'homePageBelowContent': serviceUrl + 'wxmini/homePageBelowConten', // 首页热卖商品
  'getCategory': serviceUrl + 'wxmini/getCategory', // 商品类别信息
  'getMallGoods': serviceUrl + 'wxmini/getMallGoods', // 商品分类页面商品列表
  'getGoodDetailById': serviceUrl + 'wxmini/getGoodDetailById', // 商品详情
};

const CART_INFO = 'cartInfo';//存放购物车数据
