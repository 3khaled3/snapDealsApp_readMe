import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/app/home_feature/view/widgets/categories_avatar.dart';
import 'package:snap_deals/app/home_feature/view/widgets/course_card.dart';
import 'package:snap_deals/app/home_feature/view/widgets/home_app_bar.dart';
import 'package:snap_deals/app/home_feature/view/widgets/product_card.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

import 'package:http/http.dart' as http;

class HomeViewArgs {
  //todo add any parameters you need
}

class HomeView extends StatelessWidget {
  const HomeView({this.args, super.key});
  final HomeViewArgs? args;
  static const String routeName = '/home_route';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 9, right: 9, bottom: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          18.ph,
          const HomeAppBar('Ziad Tamer'),
          18.ph,
          const Center(child: CategoriesAvatar()),
          18.ph,
          ProductsRow(),
          CustomTextFormField(
            hintText: context.tr.hintSearch,
            suffixIcon: Icons.search,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: Text(
              context.tr.popularCourse,
              style: AppTextStyles.medium20()
                  .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
            ),
          ),
          SizedBox(
            height: 275,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    10,
                    (index) => const CourseCard(
                          courseName: 'Course Name ',
                          price: 1000,
                          imagePath:
                              "https://appmaster.io/api/_files/hRaLG2N4DVjRZJQzCpN2zJ/download/",
                          courseOwner: 'Ziad tamer',
                        )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: Text(
              context.tr.popularProduct,
              style: AppTextStyles.medium20()
                  .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
            ),
          ),
          SizedBox(
            height: 275,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    10,
                    (index) => const ProductCard(
                      productName: 'Product Name',
                      price: 1000,
                      productOwner: "Ziad tamer",
                      imagePath:
                          "https://www.onlineprinters.co.uk/magazine/wp-content/uploads/2019/06/image-to-pdf.jpg",
                    ),
                  ),
                )),
          ),
          16.ph,
        ],
      ),
    );
  }
}

// Main Widget
class ProductsRow extends StatefulWidget {
  const ProductsRow({Key? key}) : super(key: key);

  @override
  createState() => _ProductsRowState();
}

class _ProductsRowState extends State<ProductsRow> {
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(
      Uri.parse(
        'https://g-project-git-zuheir-zuheirs-projects.vercel.app//api/v1/products?limit=2000',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Cookie':
            '_vercel_jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJieXBhc3MiOiJHNkhiNWtaa0xQSzNsQ2NuVlZZdmY1U3J4SmpsN3dhcyIsImF1ZCI6ImctcHJvamVjdC1naXQtenVoZWlyLXp1aGVpcnMtcHJvamVjdHMudmVyY2VsLmFwcCIsImlhdCI6MTc0NDQ1ODk3MCwic3ViIjoicHJvdGVjdGlvbi1ieXBhc3MtdXJsIn0.7su_cSpr5AXRhQWL8E3Al32SJfQAwllkubF3z__Td54',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        products = data['data'];
      });
    } else {
      print(
          '❌ Failed to load products ${response.statusCode} /// ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: products.map((product) {
          String imageUrl = product['images'].isNotEmpty
              ? "https://g-project-git-zuheir-zuheirs-projects.vercel.app/products/${product['images'][0]}"
              : "https://via.placeholder.com/150"; // Fallback image

          return CourseCard(
            courseName: product['title'],
            price: double.tryParse(product['price'].toString()) ?? 0.0,
            imagePath: imageUrl,
            courseOwner: " product['category']['name']",
          );
        }).toList(),
      ),
    );
  }
}
