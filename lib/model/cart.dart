class CartModel {
  String goodsId;
  String goodsName;
  int count;
  double price;
  String images;

  CartModel(
      {this.goodsId, this.goodsName, this.count, this.price, this.images});

  CartModel.fromJson(Map<String, dynamic> json) {
    goodsId = json['goodId'];
    goodsName = json['goodName'];
    count = json['goodCount'];
    price = json['goodPrice'];
    images = json['goodImages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodId'] = this.goodsId;
    data['goodName'] = this.goodsName;
    data['goodCount'] = this.count;
    data['goodPrice'] = this.price;
    data['goodImages'] = this.images;
    return data;
  }
}