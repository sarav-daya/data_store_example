class Product {
  final String name;
  final double price;
  final double vatInPercent;
  int amount = 0;
  Product({
    required this.name,
    required this.price,
    required this.vatInPercent,
  });
}
