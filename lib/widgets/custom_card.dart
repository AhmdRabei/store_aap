import 'package:flutter/material.dart';
import 'package:store_test/models/product_model.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.product, this.onTap});
  final ProductModel product;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 40,
                  spreadRadius: 20,
                  offset: const Offset(1, 1),
                  color: Colors.grey.withOpacity(0.2),
                ),
              ],
            ),
            child: Card(
              elevation: 10,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name.substring(0, 7),
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      product.description.substring(0, 7),
                      style: const TextStyle(fontSize: 14),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(r'$' '${product.price.toString()}'),
                        const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              right: 15,
              top: -80,
              child: SizedBox(
                height: 100,
                width: 100,
                child: Image(
                  height: 150,
                  width: 100,
                  image: NetworkImage(product.image),
                ),
              ))
        ],
      ),
    );
  }
}
