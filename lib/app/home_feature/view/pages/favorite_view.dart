import 'package:flutter/material.dart';

class FavoriteViewArgs {}

class FavoriteView extends StatelessWidget {
  const FavoriteView({this.args, super.key});
  final FavoriteViewArgs? args;
  static const String routeName = '/favorite_route';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Favorite screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
