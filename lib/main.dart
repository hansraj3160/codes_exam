import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

// import 'package:pdf_to_img/pi_chart.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quill Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: QuillEditorc(),
    );
    //   home: PDFThumbnailWidget(
    //       pdfPath:
    //           "https://github.com/rbcprolabs/packages.flutter/raw/fd0c92ac83ee355255acb306251b1adfeb2f2fd6/packages/native_pdf_renderer/example/assets/sample.pdf"),
    // );
  }
}

// // Usage example in a StatefulWidget
// class PDFThumbnailWidget extends StatefulWidget {
//   final String pdfPath;

//   PDFThumbnailWidget({required this.pdfPath});

//   @override
//   _PDFThumbnailWidgetState createState() => _PDFThumbnailWidgetState();
// }

// class _PDFThumbnailWidgetState extends State<PDFThumbnailWidget> {
//   var pageImage;
//   bool isCheck = false;
//   setLoading(bool load) {
//     setState(() {
//       isCheck = load;
//     });
//   }

//   @override
//   void initState() {
//     getPDFthumb();
//     super.initState();
//   }

//   getPDFthumb() async {
//     setLoading(true);
//     final document = await PdfDocument.openData(InternetFile.get(
//       widget.pdfPath,
//     ));
//     final page = await document.getPage(1);
//     pageImage = await page.render(
//       format: PdfPageImageFormat.png,
//       width: page.width,
//       height: page.height,
//       cropRect:
//           Rect.fromCenter(center: Offset(100, 100), width: 150, height: 150),
//     );
//     setLoading(false);
//     await page.close();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//       child: Container(
//           height: 100,
//           width: 100,
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
//           child: isCheck
//               ? null
//               : Image(
//                   image: MemoryImage(pageImage.bytes, scale: 1),
//                   filterQuality: FilterQuality.high,
//                   fit: BoxFit.fill,
//                 )),
//     ));
//   }
// }

class QuillEditorc extends StatefulWidget {
  @override
  State<QuillEditorc> createState() => _QuillEditorState();
}

class _QuillEditorState extends State<QuillEditorc> {
  QuillController _controller = QuillController.basic();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: QuillProvider(
          configurations: QuillConfigurations(
            controller: _controller,
            sharedConfigurations: const QuillSharedConfigurations(),
          ),
          child: Column(
            children: [
              QuillToolbar(
                configurations: QuillToolbarConfigurations(),
              ),
              Expanded(
                child: QuillEditor.basic(
                  configurations: const QuillEditorConfigurations(
                    readOnly: false,
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      debugPrint(
                          "Text Controller toPlainText ${_controller.document.toPlainText()}");
                      debugPrint(
                          "Text Controller ${jsonEncode(_controller.document.toDelta().toJson())}");
                    });
                  },
                  child: Text(
                      "Text Controller ${_controller.document.toPlainText()}")),
            ],
          ),
        ),
      ),
    );
  }
}
