class Product {
  final String id;
  final String name;
  final String category;
  final String brand;
  final String image;
  final double price;
  final double? oldPrice;
  final String unit;
  final String description;
  final bool isPopular;
  final bool isNew;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.brand,
    required this.image,
    required this.price,
    this.oldPrice,
    required this.unit,
    required this.description,
    this.isPopular = false,
    this.isNew = false,
  });
}

class Category {
  final String id;
  final String name;
  final String image;
  final String description;
  const Category({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
  });
}

class CataloguePage {
  final String id;
  final String title;
  final String category;
  final String image;
  final String description;

  const CataloguePage({
    required this.id,
    required this.title,
    required this.category,
    required this.image,
    this.description = 'Promotional prices are shown on the catalogue image.',
  });
}

class Brand {
  final String id;
  final String name;
  final String logo;
  final String description;
  const Brand({required this.id, required this.name, required this.logo, required this.description});
}

class Branch {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String openingHours;
  final String image;
  final String description;
  const Branch({required this.id, required this.name, required this.address, required this.phone, required this.openingHours, required this.image, required this.description});
}

class Offer {
  final String id;
  final String title;
  final String description;
  final String image;
  final String discount;
  final String category;
  const Offer({required this.id, required this.title, required this.description, required this.image, required this.discount, required this.category});
}
