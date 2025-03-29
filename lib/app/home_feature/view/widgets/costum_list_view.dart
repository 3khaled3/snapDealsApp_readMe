import 'package:flutter/material.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_products_card.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';

class ProductList extends StatelessWidget {
  ProductList({super.key});
  final List<Map<String, String>> products = [
    {
      'title': 'Hp G7 4400 laptop  intelCorei7-5200',
      'price': '5000 LE',
      'imageUrl': AppImageAssets.splashScreen,
    },
    {
      'title': 'Hp G7 4400 laptop  intelCorei7-5200',
      'price': '5000 LE',
      'imageUrl': AppImageAssets.forgotPassImage,
    },
    {
      'title': 'Hp G7 4400 laptop  intelCorei7-5200',
      'price': '5000 LE',
      'imageUrl': AppImageAssets.forgotPassImage,
    },
    {
      'title': 'Hp G7 4400 laptop  intelCorei7-5200',
      'price': '5000 LE',
      'imageUrl': AppImageAssets.forgotPassImage,
    },
    {
      'title': 'Hp G7 4400 laptop  intelCorei7-5200',
      'price': '5000 LE',
      'imageUrl': AppImageAssets.forgotPassImage,
    },

    // Add more  items here
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: CustomProductCard(
            title: products[index]['title']!,
            price: products[index]['price']!,
            imagePath: products[index]['imageUrl']!,
            isCourse: false,
          ),
        );
      },
    );
  }
}

class CourseList extends StatelessWidget {
  CourseList({super.key});
  final List<Map<String, String>> courses = [
    {
      'title': 'Drawing Basics , For Beginners',
      'price': '5000 LE',
      'imageUrl': AppImageAssets.splashScreen,
      'owner': 'Ahmed Mohamed',
    },
    {
      'title': 'Hp G7 4400 laptop  intelCorei7-5200',
      'price': '5000 LE',
      'imageUrl': AppImageAssets.forgotPassImage,
      'owner': 'Ahmed Mohamed',
    },
    {
      'title': 'Hp G7 4400 laptop  intelCorei7-5200',
      'price': '5000 LE',
      'imageUrl': AppImageAssets.forgotPassImage,
      'owner': 'Ahmed Mohamed',
    },
    {
      'title': 'Hp G7 4400 laptop  intelCorei7-5200',
      'price': '5000 LE',
      'imageUrl': AppImageAssets.forgotPassImage,
      'owner': 'Ahmed Mohamed',
    },
    {
      'title': 'Hp G7 4400 laptop  intelCorei7-5200',
      'price': '5000 LE',
      'imageUrl': AppImageAssets.forgotPassImage,
      'owner': 'Ahmed Mohamed',
    },

    // Add more  items here
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: CustomProductCard(
            title: courses[index]['title']!,
            price: courses[index]['price']!,
            imagePath: courses[index]['imageUrl']!,
            owner: courses[index]['owner']!,
            isCourse: true,
          ),
        );
      },
    );
  }
}
