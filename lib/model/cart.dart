class CartModel {
  String goodId;
  String goodName;
  int goodCount;
  double goodPrice;
  String goodImages;
  bool isCheck;

  CartModel(
      {this.goodId, this.goodName, this.goodCount, this.goodPrice, this.goodImages,this.isCheck});

  CartModel.fromJson(Map<String, dynamic> json) {
    goodId = json['goodId'];
    goodName = json['goodName'];
    goodCount = json['goodCount'];
    goodPrice = json['goodPrice'];
    goodImages = json['goodImages'];
    isCheck = json['isCheck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodId'] = this.goodId;
    data['goodName'] = this.goodName;
    data['goodCount'] = this.goodCount;
    data['goodPrice'] = this.goodPrice;
    data['goodImages'] = this.goodImages;
    data['isCheck'] = this.isCheck;
    return data;
  }
}