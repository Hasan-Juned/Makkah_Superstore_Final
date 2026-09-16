import '../models/models.dart';

const categories = <Category>[
  Category(
    id: 'personal-care',
    name: 'Personal Care',
    image: 'assets/catalog/catalog_01.jpg',
    description: 'Soap, oral care, deodorants and everyday essentials.',
  ),
  Category(
    id: 'baby-family',
    name: 'Baby & Family Care',
    image: 'assets/catalog/catalog_13.jpg',
    description: 'Baby diapers, wipes and family-care offers.',
  ),
  Category(
    id: 'grocery',
    name: 'Grocery & Pantry',
    image: 'assets/catalog/catalog_22.jpg',
    description: 'Pantry staples, spices, sauces and nutrition.',
  ),
  Category(
    id: 'frozen',
    name: 'Frozen & Ice Cream',
    image: 'assets/catalog/catalog_36.jpg',
    description: 'Frozen foods and ice-cream promotions.',
  ),
  Category(
    id: 'snacks',
    name: 'Snacks & Treats',
    image: 'assets/catalog/catalog_44.jpg',
    description: 'Chips, crackers, chocolates and sweet treats.',
  ),
];

// These are the customer's supplied catalogue pages. No product price is
// invented here: every promotional price remains visible in the original
// catalogue artwork.
const cataloguePages = <CataloguePage>[
  CataloguePage(id: '01', title: 'Savlon & personal care offers', category: 'Personal Care', image: 'assets/catalog/catalog_01.jpg'),
  CataloguePage(id: '02', title: 'SmartCare adult care offers', category: 'Personal Care', image: 'assets/catalog/catalog_02.jpg'),
  CataloguePage(id: '03', title: 'Savlon Mild Soap offers', category: 'Personal Care', image: 'assets/catalog/catalog_03.jpg'),
  CataloguePage(id: '04', title: 'Savlon Fresh Soap offers', category: 'Personal Care', image: 'assets/catalog/catalog_04.jpg'),
  CataloguePage(id: '05', title: 'Savlon soap range', category: 'Personal Care', image: 'assets/catalog/catalog_05.jpg'),
  CataloguePage(id: '06', title: 'Dettol hygiene offers', category: 'Personal Care', image: 'assets/catalog/catalog_06.jpg'),
  CataloguePage(id: '07', title: 'Dettol soap offers', category: 'Personal Care', image: 'assets/catalog/catalog_07.jpg'),
  CataloguePage(id: '08', title: 'Lux beauty soap offers', category: 'Personal Care', image: 'assets/catalog/catalog_08.jpg'),
  CataloguePage(id: '09', title: 'Lux beauty care offers', category: 'Personal Care', image: 'assets/catalog/catalog_09.jpg'),
  CataloguePage(id: '10', title: 'Skin cleansing soap offers', category: 'Personal Care', image: 'assets/catalog/catalog_10.jpg'),
  CataloguePage(id: '11', title: 'Savlon fresh care offers', category: 'Personal Care', image: 'assets/catalog/catalog_11.jpg'),
  CataloguePage(id: '12', title: 'Feminine care offers', category: 'Baby & Family Care', image: 'assets/catalog/catalog_12.jpg'),
  CataloguePage(id: '13', title: 'Savlon Twinkle baby diaper offers', category: 'Baby & Family Care', image: 'assets/catalog/catalog_13.jpg'),
  CataloguePage(id: '14', title: 'Baby care range', category: 'Baby & Family Care', image: 'assets/catalog/catalog_14.jpg'),
  CataloguePage(id: '15', title: 'Baby wipes offers', category: 'Baby & Family Care', image: 'assets/catalog/catalog_15.jpg'),
  CataloguePage(id: '16', title: 'Baby care essentials', category: 'Baby & Family Care', image: 'assets/catalog/catalog_16.jpg'),
  CataloguePage(id: '17', title: 'Family care offers', category: 'Baby & Family Care', image: 'assets/catalog/catalog_17.jpg'),
  CataloguePage(id: '18', title: 'Baby and family essentials', category: 'Baby & Family Care', image: 'assets/catalog/catalog_18.jpg'),
  CataloguePage(id: '23', title: 'Twinkle baby care offers', category: 'Baby & Family Care', image: 'assets/catalog/catalog_23.jpg'),
  CataloguePage(id: '24', title: 'Huggies baby care offers', category: 'Baby & Family Care', image: 'assets/catalog/catalog_24.jpg'),
  CataloguePage(id: '19', title: 'Everyday grocery offers', category: 'Grocery & Pantry', image: 'assets/catalog/catalog_19.jpg'),
  CataloguePage(id: '20', title: 'Pantry and grocery offers', category: 'Grocery & Pantry', image: 'assets/catalog/catalog_20.jpg'),
  CataloguePage(id: '21', title: 'Grocery essentials', category: 'Grocery & Pantry', image: 'assets/catalog/catalog_21.jpg'),
  CataloguePage(id: '22', title: 'Spices and pantry staples', category: 'Grocery & Pantry', image: 'assets/catalog/catalog_22.jpg'),
  CataloguePage(id: '25', title: 'Grocery value offers', category: 'Grocery & Pantry', image: 'assets/catalog/catalog_25.jpg'),
  CataloguePage(id: '26', title: 'Everyday food offers', category: 'Grocery & Pantry', image: 'assets/catalog/catalog_26.jpg'),
  CataloguePage(id: '27', title: 'Food cupboard offers', category: 'Grocery & Pantry', image: 'assets/catalog/catalog_27.jpg'),
  CataloguePage(id: '28', title: 'Sauces and grocery offers', category: 'Grocery & Pantry', image: 'assets/catalog/catalog_28.jpg'),
  CataloguePage(id: '29', title: 'Sauce and pantry range', category: 'Grocery & Pantry', image: 'assets/catalog/catalog_29.jpg'),
  CataloguePage(id: '30', title: 'Honey offers', category: 'Grocery & Pantry', image: 'assets/catalog/catalog_30.jpg'),
  CataloguePage(id: '31', title: 'Jelly and pantry offers', category: 'Grocery & Pantry', image: 'assets/catalog/catalog_31.jpg'),
  CataloguePage(id: '32', title: 'Horlicks and nutrition drinks', category: 'Grocery & Pantry', image: 'assets/catalog/catalog_32.jpg'),
  CataloguePage(id: '40', title: 'Milk powder and nutrition', category: 'Grocery & Pantry', image: 'assets/catalog/catalog_40.jpg'),
  CataloguePage(id: '34', title: 'Frozen food offers', category: 'Frozen & Ice Cream', image: 'assets/catalog/catalog_34.jpg'),
  CataloguePage(id: '35', title: 'Kazi Farms frozen food', category: 'Frozen & Ice Cream', image: 'assets/catalog/catalog_35.jpg'),
  CataloguePage(id: '36', title: 'Savoy ice cream offers', category: 'Frozen & Ice Cream', image: 'assets/catalog/catalog_36.jpg'),
  CataloguePage(id: '37', title: 'Savoy ice cream range', category: 'Frozen & Ice Cream', image: 'assets/catalog/catalog_37.jpg'),
  CataloguePage(id: '38', title: 'Polar ice cream offers', category: 'Frozen & Ice Cream', image: 'assets/catalog/catalog_38.jpg'),
  CataloguePage(id: '39', title: 'Paragon food offers', category: 'Frozen & Ice Cream', image: 'assets/catalog/catalog_39.jpg'),
  CataloguePage(id: '41', title: 'Hair and beauty care offers', category: 'Personal Care', image: 'assets/catalog/catalog_41.jpg'),
  CataloguePage(id: '42', title: 'NIVEA deodorant offers', category: 'Personal Care', image: 'assets/catalog/catalog_42.jpg'),
  CataloguePage(id: '33', title: 'Pepsodent oral care offers', category: 'Personal Care', image: 'assets/catalog/catalog_33.jpg'),
  CataloguePage(id: '43', title: 'Snack and food offers', category: 'Snacks & Treats', image: 'assets/catalog/catalog_43.jpg'),
  CataloguePage(id: '44', title: 'Petra potato chips', category: 'Snacks & Treats', image: 'assets/catalog/catalog_44.jpg'),
  CataloguePage(id: '45', title: 'Hup Seng cream crackers', category: 'Snacks & Treats', image: 'assets/catalog/catalog_45.jpg'),
  CataloguePage(id: '46', title: 'Coffee and snack offers', category: 'Snacks & Treats', image: 'assets/catalog/catalog_46.jpg'),
  CataloguePage(id: '47', title: 'Chocolate gift offers', category: 'Snacks & Treats', image: 'assets/catalog/catalog_47.jpg'),
  CataloguePage(id: '48', title: 'Chocolate box offers', category: 'Snacks & Treats', image: 'assets/catalog/catalog_48.jpg'),
  CataloguePage(id: '49', title: 'Chocolate and confectionery offers', category: 'Snacks & Treats', image: 'assets/catalog/catalog_49.jpg'),
  CataloguePage(id: '50', title: 'Chocolate and nuts offers', category: 'Snacks & Treats', image: 'assets/catalog/catalog_50.jpg'),
  CataloguePage(id: '51', title: 'Coconut and grocery offer', category: 'Grocery & Pantry', image: 'assets/catalog/catalog_51.jpg'),
  CataloguePage(id: '52', title: 'Nutella chocolate spread', category: 'Snacks & Treats', image: 'assets/catalog/catalog_52.jpg'),
];

// Retained only for legacy product-detail code. Customer-facing catalogue
// pages use the real supplied artwork above, so these placeholder prices are
// not shown anywhere in the catalogue UI.
const products = <Product>[];

const offers = <Offer>[
  Offer(id: 'o1', title: 'Personal care promotions', description: 'Browse the supplied catalogue pages for current promotional prices.', image: 'assets/catalog/catalog_06.jpg', discount: 'Current catalogue', category: 'Personal Care'),
  Offer(id: 'o2', title: 'Grocery promotions', description: 'Pantry, nutrition and everyday grocery offers from the supplied catalogue.', image: 'assets/catalog/catalog_22.jpg', discount: 'Current catalogue', category: 'Grocery & Pantry'),
  Offer(id: 'o3', title: 'Ice cream & frozen offers', description: 'See the original promotional artwork and prices for frozen favourites.', image: 'assets/catalog/catalog_36.jpg', discount: 'Current catalogue', category: 'Frozen & Ice Cream'),
];

const brands = <Brand>[
  Brand(id: 'b1', name: 'PRAN', logo: 'PRAN', description: 'Everyday favourites made for Bangladeshi families.'),
  Brand(id: 'b2', name: 'Nestlé', logo: 'nestlé', description: 'Trusted nutrition and quality across generations.'),
  Brand(id: 'b3', name: 'Unilever', logo: 'unilever', description: 'Household and personal care essentials.'),
  Brand(id: 'b4', name: 'Coca-Cola', logo: 'Coca-Cola', description: 'Refreshment for every occasion.'),
  Brand(id: 'b5', name: 'Aarong Dairy', logo: 'Aarong\nDairy', description: 'Fresh dairy from a trusted local name.'),
  Brand(id: 'b6', name: 'Fresh', logo: 'fresh', description: 'Simple, reliable household staples.'),
];

const branches = <Branch>[
  Branch(id: 'br1', name: 'Main Branch', address: '12 Station Road, Sylhet', phone: '+880 1711 000 111', openingHours: '8:00 AM – 10:00 PM', image: 'assets/logo/makkah_superstore_logo.jpg', description: 'Our flagship store with the widest range of fresh food, groceries and household essentials.'),
  Branch(id: 'br2', name: 'Amberkhana Branch', address: 'Amberkhana Point, Sylhet', phone: '+880 1711 000 222', openingHours: '8:00 AM – 10:00 PM', image: 'assets/logo/makkah_superstore_logo.jpg', description: 'A convenient neighbourhood branch for quick everyday shopping.'),
  Branch(id: 'br3', name: 'Zindabazar Branch', address: '45 Zindabazar, Sylhet', phone: '+880 1711 000 333', openingHours: '9:00 AM – 9:30 PM', image: 'assets/logo/makkah_superstore_logo.jpg', description: 'Right in the heart of the city, with fresh produce and trusted brands.'),
  Branch(id: 'br4', name: 'Uposhohor Branch', address: 'Uposhohor Main Road, Sylhet', phone: '+880 1711 000 444', openingHours: '8:00 AM – 10:00 PM', image: 'assets/logo/makkah_superstore_logo.jpg', description: 'A spacious, family-friendly store with easy access and parking.'),
];

const reviews = [
  ('Nabila Rahman', 'Great collection of fresh products and a very convenient shopping experience.', 'NR'),
  ('Sajid Ahmed', 'The staff are helpful and I can always find my regular household brands here.', 'SA'),
  ('Farhana Karim', 'I love the fresh fruit selection. Everything is clean and well presented.', 'FK'),
  ('Rafi Chowdhury', 'A dependable neighbourhood super shop with fair prices and good variety.', 'RC'),
];
