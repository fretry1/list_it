class Category {
  final int id;
  final String title;

  Category(this.id, String title) : title = title.toUpperCase();

  static final Map<DefaultCategory, Category> defaults = Map.fromEntries(
    DefaultCategory.values.map(
      (entry) => MapEntry(entry, Category(entry.id, entry.title))
    )
  );
}

enum DefaultCategory {
  uncategorized(1, 'UNCATEGORIZED'),
  baby(2, 'BABY'),
  bakery(3, 'BAKED GOODS'),
  canned(4, 'CANNED FOOD'),
  deli(5, 'DELI'),
  dairyAndEggs(6, 'DAIRY & EGGS'),
  drinks(7, 'DRINKS'),
  fish(8, 'FISH & SEAFOOD'),
  frozen(9, 'FROZEN'),
  fruitsAndVegetables(10, 'FRUITS & VEGETABLES'),
  candy(11, 'CANDY'),
  snacks(12, 'SNACKS'),
  baking(13, 'BAKING'),
  pantry(14, 'PANTRY'),
  spices(15, 'SPICES'),
  convenienceFood(16, 'CONVENIENCE FOOD'),
  alcohol(17, 'ALCOHOL'),
  coffeeAndTea(18, 'COFFEE & TEA'),
  hygiene(19, 'HYGIENE'),
  cleaning(20, 'CLEANING'),
  animal(21, 'ANIMAL'),
  gardenAndDIY(22, 'GARDEN & DIY');

  final int id;
  final String title;

  const DefaultCategory(this.id, this.title);
}