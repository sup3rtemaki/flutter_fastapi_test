enum Category{
  Produce,
  Bakery,
  Dairy,
  Frozen,
  Aisle,
  Household,
  Misc
}

const GroceryItemCategoryMap = {
  Category.Produce: 'hortifruti',
  Category.Bakery: 'padaria',
  Category.Dairy: 'laticinios',
  Category.Frozen: 'congelados',
  Category.Aisle: 'naopereciveis',
  Category.Household: 'limpeza',
  Category.Misc: 'geral',
};

class GroceryItem{
  int? id;
  String name = "";
  Category? category;
  bool purchased = false;

  GroceryItem(){
    //TODO
  }

  GroceryItem.fromJson(Map<String, dynamic> json){
    this.id = json['id'];
    this.name = json['name'];
    this.category = json['category'] != null
        ? GroceryItem.categoryFromString(json['category'])
        : Category.Misc;
    this.purchased = json['purchased'] != null ? json['purchased'] : false;
  }

  get categoryLabel{
    if(this.category == null){
      return "-";
    }

    return GroceryItem.stringFromCategory(this.category!);
  }

  get categoryValue {
    if(this.category == null){
      return "geral";
    }

    return GroceryItem.stringFromCategory(this.category!);
  }

  static Category? categoryFromString(String category) {
    return GroceryItemCategoryMap.entries
        .firstWhere((element) => element.value == category)
        .key;
  }

  static String? stringFromCategory(Category category) {
    return GroceryItemCategoryMap[category];
  }
}