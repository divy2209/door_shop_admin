class Order{
  final String orderId;
  final String customer;
  final List<dynamic> crops;
  final List<dynamic> prices;
  final List<dynamic> discounts;
  final List<dynamic> quantities;
  final List<dynamic> address;
  final List<dynamic> units;
  final int subtotal;
  final int total;
  final String dateTime;
  final int status;
  final String deliveryDate;
  final String email;
  final int contact;

  Order({this.email, this.contact, this.customer, this.orderId, this.crops, this.prices, this.discounts, this.quantities, this.address, this.total, this.subtotal, this.dateTime, this.status, this.units, this.deliveryDate});
}