class Coffee {
  final String id;
  final String name;
  final String imagePath;
  final double price;
  final String description;
  final String volume;

  const Coffee(
      {required this.id,
      required this.name,
      required this.imagePath,
      required this.price,
      required this.description,
      required this.volume});

  String get _id => id;
  String get _name => name;
  String get _imagePath => imagePath;
  double get _price => price;
  String get _description => description;
  String get _volume => volume;
}
