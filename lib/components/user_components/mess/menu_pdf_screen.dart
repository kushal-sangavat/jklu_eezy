import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:open_file/open_file.dart';

class MenuPdfScreen extends StatefulWidget {
  final String backendBaseUrl; // e.g. "http://10.0.2.2:3000" or your server
  final String token; // bearer token

  const MenuPdfScreen({Key? key, required this.backendBaseUrl, required this.token}) : super(key: key);

  @override
  _MenuPdfScreenState createState() => _MenuPdfScreenState();
}

class _MenuPdfScreenState extends State<MenuPdfScreen> {
  String? localFilePath;
  bool loading = false;
  final Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    fetchPdf();
  }

  Future<void> fetchPdf({String format = 'pdf'}) async {
    setState(() => loading = true);
    try {
      final url = "${widget.backendBaseUrl}/api/menu/file?format=$format";
      final response = await dio.get<List<int>>(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {"Authorization": "Bearer ${widget.token}"},
        ),
      );

      if (response.statusCode == 200) {
        Uint8List bytes = Uint8List.fromList(response.data!);
        final dir = await getTemporaryDirectory();
        final filePath = "${dir.path}/menu_${DateTime.now().millisecondsSinceEpoch}.$format";
        final file = File(filePath);
        await file.writeAsBytes(bytes, flush: true);
        setState(() {
          localFilePath = filePath;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to fetch PDF: ${response.statusCode}")));
      }
    } catch (e) {
      print("fetchPdf error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => loading = false);
    }
  }

  void openFile() {
    if (localFilePath != null) {
      OpenFile.open(localFilePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weekly Menu"),
        actions: [
          IconButton(
            onPressed: () => fetchPdf(format: 'pdf'), // re-fetch pdf
            icon: const Icon(Icons.refresh),
            tooltip: "Refresh PDF",
          ),
          IconButton(
            onPressed: () => fetchPdf(format: 'png'),
            icon: const Icon(Icons.image),
            tooltip: "Get PNG",
          ),
          IconButton(
            onPressed: openFile,
            icon: const Icon(Icons.download),
            tooltip: "Open / Download",
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : localFilePath == null
              ? const Center(child: Text("No file. Tap refresh."))
              : _buildPdfView(localFilePath!),
    );
  }

  Widget _buildPdfView(String path) {
    // If path ends with png, show image, else show PDF viewer
    if (path.toLowerCase().endsWith('.png')) {
      return Center(child: Image.file(File(path)));
    }
    return PDFView(
      filePath: path,
      enableSwipe: true,
      swipeHorizontal: false,
      autoSpacing: true,
      pageFling: true,
      onError: (error) {
        print(error);
      },
      onPageError: (page, error) {
        print('$page: ${error.toString()}');
      },
    );
  }
}
