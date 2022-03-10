import 'dart:io';
import 'dart:typed_data';

import 'package:data_store_example/models/product.dart';
import 'package:flutter/services.dart';
import 'package:open_document/open_document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CustomRow {
  final String itemName;
  final String itemPrice;
  final String amount;
  final String total;
  final String vat;

  CustomRow(this.itemName, this.itemPrice, this.amount, this.total, this.vat);
}

class PdfInvoiceService {
  Future<Uint8List> createHelloWorld() {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Center(
            child: pw.Text(
              'Hello World!!!',
              style: pw.TextStyle(fontSize: 52.0),
            ),
          );
        },
      ),
    );
    return pdf.save();
  }

  Future<void> savePdfFile(String fileName, Uint8List bytesList) async {
    final output = await getTemporaryDirectory();
    // print(output);
    var filePath = "${output.path}/$fileName.pdf";
    final file = File(filePath);
    await file.writeAsBytes(bytesList);
    // print('File Written to : $filePath');
    OpenDocument.openDocument(filePath: file.path)
        .then((value) => file.delete());
  }

  Future<Uint8List> createInvoice(List<Product> products) async {
    final pdf =
        pw.Document(author: 'https://auguryapps.com', title: 'ULTIMATE QR');
    final List<CustomRow> elements = [
      for (var product in products)
        CustomRow(
          product.name,
          product.price.toStringAsFixed(2),
          product.amount.toStringAsFixed(2),
          (product.price * product.amount).toStringAsFixed(2),
          (product.vatInPercent * 0.01 * product.price).toStringAsFixed(2),
        ),
      CustomRow(
        "Sub Total",
        "",
        "",
        "",
        "${getSubTotal(products)} \$",
      ),
      CustomRow(
        "Vat Total",
        "",
        "",
        "",
        "${getVatTotal(products)} \$",
      ),
      CustomRow(
        "Total",
        "",
        "",
        "",
        "${(double.parse(getSubTotal(products)) + double.parse(getVatTotal(products))).toStringAsFixed(2)} \$",
      ),
    ];

    final image = (await rootBundle.load('assets/images/background2.png'))
        .buffer
        .asUint8List();
    var data = await rootBundle.load("assets/fonts/Nunito-Regular.ttf");
    pdf.addPage(
      pw.Page(
        theme: pw.ThemeData.withFont(base: pw.Font.ttf(data)),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Image(pw.MemoryImage(image),
                  width: 150, height: 150, fit: pw.BoxFit.cover),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Customer Name"),
                      pw.Text("Customer Address"),
                      pw.Text("Customer City"),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Max Weber"),
                      pw.Text("Weired Street Name"),
                      pw.Text("77662 Someones City"),
                      pw.Text("Vat-id: 123456789"),
                      pw.Text("Invoice-Nr: 00001"),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 50.0),
              pw.Row(children: [
                pw.Expanded(
                  flex: 1,
                  child: pw.Text(
                    'Item Name',
                    style: pw.TextStyle(
                      color: PdfColor.fromHex(
                        '533E85',
                      ),
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    textAlign: pw.TextAlign.left,
                  ),
                ),
                pw.Expanded(
                  child: pw.Text(
                    'Price',
                    style: pw.TextStyle(
                      color: PdfColor.fromHex('533E85'),
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    textAlign: pw.TextAlign.right,
                  ),
                ),
                pw.Expanded(
                  child: pw.Text(
                    'Amount',
                    style: pw.TextStyle(
                      color: PdfColor.fromHex('533E85'),
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    textAlign: pw.TextAlign.right,
                  ),
                ),
                pw.Expanded(
                  child: pw.Text(
                    'Total',
                    style: pw.TextStyle(
                      color: PdfColor.fromHex('533E85'),
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    textAlign: pw.TextAlign.right,
                  ),
                ),
                pw.Expanded(
                  child: pw.Text(
                    'VAT',
                    style: pw.TextStyle(
                      color: PdfColor.fromHex('533E85'),
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    textAlign: pw.TextAlign.right,
                  ),
                ),
              ]),
              pw.Divider(
                height: 2,
              ),
              pw.SizedBox(height: 5.0),
              for (var row in elements)
                pw.Column(
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Expanded(
                          flex: 1,
                          child: pw.Text(
                            row.itemName,
                            style: pw.TextStyle(fontSize: 14),
                            textAlign: pw.TextAlign.left,
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                            row.itemPrice,
                            style: pw.TextStyle(fontSize: 14),
                            textAlign: pw.TextAlign.right,
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                            row.vat,
                            style: pw.TextStyle(fontSize: 14),
                            textAlign: pw.TextAlign.right,
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                            row.amount,
                            style: pw.TextStyle(fontSize: 14),
                            textAlign: pw.TextAlign.right,
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                            row.total,
                            style: pw.TextStyle(fontSize: 14),
                            textAlign: pw.TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    pw.Divider(
                      height: 2,
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  String getSubTotal(List<Product> products) {
    return products
        .fold(0.0,
            (double prev, element) => prev + (element.amount * element.price))
        .toStringAsFixed(2);
  }

  String getVatTotal(List<Product> products) {
    return products
        .fold(
          0.0,
          (double prev, next) =>
              prev + ((next.price / 100 * next.vatInPercent) * next.amount),
        )
        .toStringAsFixed(2);
  }
}
