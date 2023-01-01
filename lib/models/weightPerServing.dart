class  weightPerServing {

  int amount= 0;
  String unit = "g" ;

  weightPerServing.fromJson(Map json) {
    this.amount = json['amount'];
    this.unit = json['unit'];

  }
}