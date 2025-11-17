import 'package:flutter/material.dart';
import 'package:turboa_mobile/models/product_entry.dart';
import 'package:turboa_mobile/widgets/left_drawer.dart';
import 'package:turboa_mobile/screens/product_detail.dart';
import 'package:turboa_mobile/widgets/product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

enum ProductFilter { all, myProducts }

class ProductEntryListPage extends StatefulWidget {
  final ProductFilter initialFilter;

  const ProductEntryListPage({
    super.key,
    this.initialFilter = ProductFilter.all,
  });

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  late ProductFilter _selectedFilter;
  late Future<List<ProductEntry>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.initialFilter;
    final request = context.read<CookieRequest>();
    _productsFuture = fetchProducts(request, _selectedFilter);
  }

  Future<List<ProductEntry>> fetchProducts(
    CookieRequest request,
    ProductFilter filter,
  ) async {
    final String url;
    if (filter == ProductFilter.myProducts) {
      url = 'http://localhost:8000/my-products-json/';
    } else {
      url = 'http://localhost:8000/json/';
    }
    final response = await request.get(url);
    var data = response;
    List<ProductEntry> listProducts = [];
    for (var d in data) {
      if (d != null) {
        listProducts.add(ProductEntry.fromJson(d));
      }
    }
    return listProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedFilter == ProductFilter.all ? 'All Products' : 'My Products',
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<ProductEntry>>(
        future: _productsFuture,
        builder: (context, AsyncSnapshot<List<ProductEntry>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Gagal memuat data.\nError: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red[700], fontSize: 16),
                ),
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'There are no products in the list yet.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, index) => ProductEntryCard(
              product: snapshot.data![index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailPage(product: snapshot.data![index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
