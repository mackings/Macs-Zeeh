
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Connectv2 extends StatefulWidget {
  const Connectv2({super.key});

  @override
  State<Connectv2> createState() => _Connectv2State();
}

class _Connectv2State extends State<Connectv2> {

  final Uri _url = Uri.parse('https://direct-debit-widget.vercel.app/Fedora-Pro');
  Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}


 final controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
       
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
        if (request.url.startsWith('https://www.youtube.com/')) {
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    ),
  )
  ..loadRequest(Uri.parse('https://widget.zeeh.africa/Fedora-Pro'));

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
       centerTitle: true,
        title: Text("Connect account",style: GoogleFonts.dmSans(
          fontWeight: FontWeight.bold
        ),),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}