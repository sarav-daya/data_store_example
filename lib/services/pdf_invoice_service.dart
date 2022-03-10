import 'dart:io';
import 'dart:typed_data';

import 'package:data_store_example/models/product.dart';
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
            child: pw.Text('Hello World!!!'),
          );
        },
      ),
    );
    return pdf.save();
  }

  Future<void> savePdfFile(String fileName, Uint8List bytesList) async {
    final output = await getTemporaryDirectory();
    var filePath = "${output.path}/$fileName.pdf";
    final file = File(filePath);
    await file.writeAsBytes(bytesList);
    await OpenDocument.openDocument(filePath: fileName);
  }

  createInvoice(Product product) {}
}
