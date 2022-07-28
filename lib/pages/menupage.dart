import 'package:flutter/material.dart';

import '../datamanager.dart';
import '../datamodel.dart';

class MenuPage extends StatelessWidget {
  final DataManager dataManager;
  const MenuPage({Key? key, required this.dataManager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var p = Product(id: 1, name: "New Product", price: 1.25, image: '');
    return FutureBuilder(
        future: dataManager.getMenu(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            var categories = snapshot.data! as List<Category>;
            return ListView.builder(
                itemCount: categories.length,
                itemBuilder: ((context, index) {
                  var products = categories[index].products;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(categories[index].name),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: products.length,
                          itemBuilder: ((context, prodIndex) {
                            var product = products[prodIndex];

                            return ProductItem(
                              product: product,
                              onAdd: (prod) => dataManager.cartAdd(prod),
                            );
                          }))
                    ],
                  );
                }));
          } else {
            if (snapshot.hasError) {
              return const Text("There was an error");
            } else {
              return const CircularProgressIndicator();
            }
          }
        }));
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final Function onAdd;

  const ProductItem({Key? key, required this.product, required this.onAdd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          elevation: 4,
          child: Column(
            children: [
              Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
              Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text("\$${product.price.toStringAsFixed(2)}"),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          onAdd(product);
                        },
                        child: const Text("Add"),
                      )
                    ],
                  )),
            ],
          )),
    );
  }
}
