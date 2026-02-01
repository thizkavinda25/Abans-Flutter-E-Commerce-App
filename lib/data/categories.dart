import 'package:abans_online/models/category_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Categories {
  static List<Category> list = [
    Category(id: 'tv', name: 'TV', icon: FontAwesomeIcons.tv),
    Category(
      id: 'av',
      name: 'Audio & Video',
      icon: FontAwesomeIcons.headphones,
    ),
    Category(
      id: 'home_appl',
      name: 'Home Appliances',
      icon: FontAwesomeIcons.house,
    ),
    Category(
      id: 'kitchen_appl',
      name: 'Kitchen Appliances',
      icon: FontAwesomeIcons.kitchenSet,
    ),
  ];

  Category findCategoryById(String id){
    return list.firstWhere((element) => element.id == id);
  }
}
