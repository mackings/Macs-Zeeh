import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/feature/connect_account/view/success_screen.dart';

class ConnectAccountPackageWidget extends ConsumerStatefulWidget {
  const ConnectAccountPackageWidget({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  ConsumerState<ConnectAccountPackageWidget> createState() =>
      _ConnectAccountWebviewState();
}

class _ConnectAccountWebviewState
    extends ConsumerState<ConnectAccountPackageWidget> {
  //
  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            if (url.contains("/ZeehTrybe/success")) {
              navigateReplace(
                context,
                ConnectAccountSuccessScreen(
                  userId: widget.userId,
                ),
              );
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.google.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://widget.zeeh.africa/ZeehTrybe?userReference=${widget.userId}'));

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: WebViewWidget(controller: controller),
            ),
          ],
        ),
      ),
    );
  }
}
