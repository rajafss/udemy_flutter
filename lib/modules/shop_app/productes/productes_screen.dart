
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Products Screen',
        style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
