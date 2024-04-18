// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:store_test/models/product_model.dart';
import 'package:store_test/services/update_product.dart';
import 'package:store_test/widgets/custom_botton.dart';
import 'package:store_test/widgets/custom_text_field.dart';

class EditView extends StatefulWidget {
  const EditView({super.key});
  static String id = 'EditView';

  @override
  State<EditView> createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  String? productName, image, desc, price;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var product = ModalRoute.of(context)!.settings.arguments as ProductModel;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Product'),
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  CustomTextField(
                    label: product.name.substring(0, 8),
                    validatorText: '',
                    onChanged: (value) {
                      productName = value;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  CustomTextField(
                    label: product.description.substring(0, 8),
                    validatorText: '',
                    onChanged: (value) {
                      desc = value;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  CustomTextField(
                    label: product.price.toString(),
                    validatorText: '',
                    onChanged: (value) {
                      price = value;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  CustomTextField(
                    label: 'image',
                    validatorText: '',
                    onChanged: (value) {
                      image = value;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  CustomButton(
                    title: 'Update Product',
                    onTap: () async {
                      isLoading = true;
                      setState(() {});
                      try {
                        await updateProduct(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Success')));
                        Navigator.pop(context);
                      } catch (e) {
                        throw Exception('error');
                      }
                      isLoading = false;
                      setState(() {});
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateProduct(ProductModel product) async {
    await UpdateProduct().updateProduct(
      id: product.id,
      title: productName == null ? product.name : productName!,
      price: price == null ? product.price.toString() : price!,
      desc: desc == null ? product.description : desc!,
      image: image == null ? product.image : image!,
      category: product.category,
    );
  }
}
