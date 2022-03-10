import 'dart:typed_data';

import 'package:data_store_example/services/pdf_invoice_service.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class PdfInvoicePage extends StatefulWidget {
  const PdfInvoicePage({Key? key}) : super(key: key);

  @override
  State<PdfInvoicePage> createState() => _PdfInvoicePageState();
}

class _PdfInvoicePageState extends State<PdfInvoicePage> {
  final PdfInvoiceService service = PdfInvoiceService();

  List<Product> products = [
    Product(name: "Membership", price: 99.99, vatInPercent: 19),
    Product(name: "Nails", price: 0.3, vatInPercent: 19),
    Product(name: "Hammer", price: 26.43, vatInPercent: 19),
    Product(name: "Hamburger", price: 5.99, vatInPercent: 19),
  ];

  int number = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice Generator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final currentProduct = products[index];
                  return Row(
                    children: [
                      Expanded(
                        child: Text(currentProduct.name),
                        flex: 3,
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Text(
                                "Price: ${currentProduct.price.toStringAsFixed(2)} \$"),
                            Text(
                                "VAT: ${currentProduct.vatInPercent.toStringAsFixed(0)} %"),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: IconButton(
                                onPressed: () =>
                                    setState(() => currentProduct.amount++),
                                icon: const Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          currentProduct.amount.toString(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () =>
                              setState(() => currentProduct.amount--),
                          icon: const Icon(Icons.remove),
                        ),
                      ),
                    ],
                  );
                },
                itemCount: products.length,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('VAR'),
                Text("${getVat()} \$"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total'),
                Text("${getTotal()} \$"),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                Uint8List bytes = await service.createInvoice(products);
                service.savePdfFile('example', bytes);
              },
              child: const Text("Create Invoice"),
            ),
          ],
        ),
      ),
    );
  }

  getTotal() => products
      .fold(0.0,
          (double prev, element) => prev + (element.price * element.amount))
      .toStringAsFixed(2);

  getVat() => products
      .fold(
          0.0,
          (double prev, element) =>
              prev +
              (element.price / 100 * element.vatInPercent * element.amount))
      .toStringAsFixed(2);
}
