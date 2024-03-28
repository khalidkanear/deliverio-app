
import 'CustomerDetails.dart';
import 'MerchantDetails.dart';
import 'OrderItem.dart';

class OrderDetails {
  List<OrderItem> ?orderItems;
  String ?orderNumber, timePickup, timeDelivery;
  String?    refNo;
  int? tax;
  double? total;
  CustomerDetails ?customerDetails;
  MerchantDetails? merchantDetails;
  String ?distance;

  OrderDetails({
    this.total,
    this.tax,
    this.refNo,
    required this.orderItems,
    required this.orderNumber,
    required this.timeDelivery,
    required this.timePickup,
    this.merchantDetails,
    this.customerDetails,
    this.distance,
  });
}

OrderDetails order = OrderDetails(
  total: 12.80,
  tax: 0,
  orderNumber: "1234",
  timeDelivery: "1:06:00",
  timePickup: "2:00:00",
  orderItems: [
    OrderItem(
        store: "MyPerwajaGrocery",
        sku: "MF00122GNC",
        quantity: 2,
        price: 6.4,
        name: "Tomato Ketchap"),
    OrderItem(
        store: "MyPerwajaGrocery",
        sku: "MF00122GNC",
        quantity: 2,
        price: 6.4,
        name: "Chilli Sauce")
  ],
  customerDetails: CustomerDetails(
      name: "Sahba",
      lat: "34.1234",
      long: "75.123456",
      image: "abc.com",
      phoneNo: "03204100904"),
  merchantDetails: MerchantDetails(
      address: "H#2 123 Sector B Malaysia.",
      name: "MyPerwajaGrocery",
      long: "74.22222",
      lat: "34.22222",
      image: "abc.com",
      phoneNo: "03201234567"),
);
