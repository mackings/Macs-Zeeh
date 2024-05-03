import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zeeh_mobile/common/components/loading_indicator.dart';

class SupportScreenWebView extends StatefulWidget {
  const SupportScreenWebView({super.key});

  @override
  State<SupportScreenWebView> createState() => _SupportScreenWebViewState();
}

class _SupportScreenWebViewState extends State<SupportScreenWebView> {
  bool isLoading = true;

  late WebViewController controller;

  updateLoad(bool update) {
    setState(() {
      isLoading = update;
    });
  }

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) =>
            updateLoad(true),
          onPageFinished: (String url) =>
            updateLoad(false),
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.google.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
          Uri.parse('https://tawk.to/chat/64a6a9a694cf5d49dc61e5ea/1h4lgddhc'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                children: [
                  if (isLoading)
                    const Center(
                      child: LoadingIndicatorWidget(
                        height: 50,
                        width: 50,
                      ),
                    ),
                  WebViewWidget(controller: controller),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
