import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suryagemilangjaya/models/product_model.dart';
import '../service/product_services.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<List<ProductModel>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = loadProducts();
  }

  @override
  Widget build(BuildContext context) {
       const Center(child: Divider(color: Colors.blue));
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<ProductModel>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products available.'));
          }
          const Center(child: Divider(color: Colors.blue));

          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    product.image,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                
                title: Text(
                  product.title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.price,
                            style: GoogleFonts.inter(
                              color: Colors.green,
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 150),
                                  child: Text(
                                    product.category,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(fontSize: 14),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text('|',
                                  style: TextStyle(color: Colors.grey)),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  product.barcode,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(61, 117, 193, 255),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            product.stock,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(product: product),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title, style: GoogleFonts.inter())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.image,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              product.title,
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.price,
              style: GoogleFonts.inter(
                fontSize: 20,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Category: ${product.category}',
              style: GoogleFonts.inter(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Barcode: ${product.barcode}',
              style: GoogleFonts.inter(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Stock: ${product.stock}',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
