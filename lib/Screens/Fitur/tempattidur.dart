import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KamarTidur extends StatefulWidget {
  @override
  _KamarTidur createState() => _KamarTidur();
}

class _KamarTidur extends State<KamarTidur> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ketersediaan Tempat Tidur"),
      ),
      body: WebView(
        initialUrl:
            "https://yankes.kemkes.go.id/app/siranap/tempat_tidur?kode_rs=3307013&jenis=1&propinsi=33prop&kabkota=3307",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
