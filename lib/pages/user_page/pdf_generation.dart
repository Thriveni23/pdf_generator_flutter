import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_app/data/data_model/user_model.dart';
import 'package:flutter_chat_app/data/data_model/profile_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart' as p;
import 'package:universal_html/html.dart' as uh;

class PdfGeneration {
  static Future<void> generatePdf(ProfileModel profile) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: p.PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Stack(
            children: [
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: p.PdfColors.black,
                    width: 1.0,
                  ),
                ),
                padding: const pw.EdgeInsets.all(11.0),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                  children: [
                    pw.SizedBox(height: 15),
                    pw.Align(
                      alignment: pw.Alignment.topCenter,
                      child: pw.Text(
                        'PERSONAL INFORMATION',
                        style: pw.TextStyle(
                          fontSize: 15,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.SizedBox(height: 40),
                    pw.Row(
                      children: [
                        pw.Expanded(child: generateTable(profile)),
                        pw.SizedBox(width: 10), // Space between the tables
                      ],
                    ),
                    pw.SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    final Uint8List pdfBytes = await pdf.save();
    final uh.Blob pdfBlob = uh.Blob([pdfBytes]);
    final url = uh.Url.createObjectUrlFromBlob(pdfBlob);
    // ignore: unused_local_variable
    final anchor = uh.AnchorElement(href: url)
      ..target = 'webpdf'
      ..download = '${profile.firstName}_Details.pdf'
      ..click();
    uh.Url.revokeObjectUrl(url);

    //   await Printing.layoutPdf(
    //     onLayout: (PdfPageFormat format) async => pdf.save(),
    //   );
  }

  static pw.Widget generateTable(ProfileModel profile) {
    final descriptions = [
      '    First Name',
      '    Last Name',
      '    Email Address',
      '    Address',
      '    Gender',
      '    Date of Birth',
      '    Religion',
      '    BloodGroup',
      '    Age',
      '    Nationality',
      '    Phone Number',
      '    designation'
    ];

    final details = [
      profile.firstName ?? '',
      profile.lastName ?? '',
      profile.emailAddress ?? '',
      profile.address ?? '',
      profile.gender ?? '',
      profile.DOB ?? '',
      profile.phoneNumber ?? '',
      profile.age ?? '',
      profile.bloodGroup??'',
      profile.religion ?? '',
      profile.nationality ?? '',
      profile.designation ?? '',

    ];

    return pw.Table(
      border: pw.TableBorder.all(),
      columnWidths: {
        0: const pw.FlexColumnWidth(1),
        1: const pw.FlexColumnWidth(2),
      },
      children: [
        for (int i = 0; i < descriptions.length; i++)
          pw.TableRow(
            children: [
              pw.Container(
                alignment: pw.Alignment.center,
                padding: const pw.EdgeInsets.all(10.0),
                child: pw.Text(
                  descriptions[i],
                  style: pw.TextStyle(fontSize: 11),
                ),
              ),
              pw.Container(
                alignment: pw.Alignment.center,
                padding: const pw.EdgeInsets.all(5.0),
                child: pw.Text(
                  details[i],
                  style: pw.TextStyle(fontSize: 11),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
