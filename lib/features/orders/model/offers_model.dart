class OffersModel {
  String bonusProducts;
  dynamic bonusAmount;
  dynamic amount;
  dynamic amountTo;
  dynamic tax;
  dynamic vat;

  OffersModel(
    {
      required this.amount,
      required this.amountTo,
      required this.bonusAmount,
      required this.bonusProducts,
      required this.tax,
      required this.vat
    }
  );

  factory OffersModel.fromJson(Map<String, dynamic> json) {
    return OffersModel(
      amount: json['amount'],
      amountTo: json['amount_to'],
      bonusAmount: json['bonus_amount'],
      bonusProducts: json['bonus_product'] ,
      tax: json['tax_value'],
      vat: json['tax']
    );
  }
}
