class CartModel {
  String goodsId;
  String goodsName;
  int goodCount;
  double goodPrice;
  String goodImages;

  CartModel(
      {this.goodsId, this.goodsName, this.goodCount, this.goodPrice, this.goodImages});

  CartModel.fromJson(Map<String, dynamic> json) {
    goodsId = json['goodId'];
    goodsName = json['goodName'];
    goodCount = json['goodCount'];
    goodPrice = json['goodPrice'];
    goodImages = json['goodImages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodId'] = this.goodsId;
    data['goodName'] = this.goodsName;
    data['goodCount'] = this.goodCount;
    data['goodPrice'] = this.goodPrice;
    data['goodImages'] = this.goodImages;
    return data;
  }
}