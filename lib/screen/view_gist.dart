// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// class GistViewer1 extends StatelessWidget {
//   GistViewer1({super.key});
//   static const String id = '/privacy_policy';
//   final homeController = Get.find<HomeController>();
//   WebViewController? controller = WebViewController()
//     ..setJavaScriptMode(JavaScriptMode.unrestricted)
//     ..setBackgroundColor(Colors.white)
//     ..setNavigationDelegate(
//       NavigationDelegate(
//         onProgress: (int progress) {
//           // Update loading bar.
//         },
//         onPageStarted: (String url) {},
//         onPageFinished: (String url) {},
//         onWebResourceError: (WebResourceError error) {},
//         onNavigationRequest: (NavigationRequest request) {
//           if (request.url
//               .startsWith('https://www.innopay.in/privacy-policy')) {
//             return NavigationDecision.prevent;
//           }
//           return NavigationDecision.navigate;
//         },
//       ),
//     )
//     ..loadRequest(Uri.parse('https://www.innopay.in/privacy-policy'));

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Obx(() => Stack(
//             children: [
//               WebViewWidget(
//                 controller: controller!,
//               ),
//               // WebView(
//               //   onPageStarted: (value) {
//               //     homeController.isWebLoading.value = true;
//               //   },
//               //   onPageFinished: (value) {
//               //     homeController.isWebLoading.value = false;
//               //   },
//               //   initialUrl: 'https://epayrent.in/privacy',
//               //   javascriptMode: JavascriptMode.unrestricted,
//               //   onWebResourceError: (value) {
//               //     print("error ${value.errorType}");
//               //   },
//               //   allowsInlineMediaPlayback: true,
//               // ),
//               Visibility(
//                 visible: homeController.isWebLoading.value == true,
//                 child: const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               )
//             ],
//           )),
//     );
//   }
// }

class GistViewer extends StatefulWidget {
  const GistViewer({super.key, required this.id});

  final String id;
  @override
  State<GistViewer> createState() => _GistViewerState();
}

class _GistViewerState extends State<GistViewer> {
  late WebViewController webViewController;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
          onHttpAuthRequest: (HttpAuthRequest request) {
            // openDialog(request);
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse('https://dartpad.dev/?id=${widget.id}'));

    // #docregion platform_features
    // if (controller.platform is AndroidWebViewController) {
    //   AndroidWebViewController.enableDebugging(true);
    //   (controller.platform as AndroidWebViewController)
    //       .setMediaPlaybackRequiresUserGesture(false);
    // }
    // #enddocregion platform_features

    webViewController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GIST PROGRAM"),
      ),
      body: SafeArea(
          child: WebViewWidget(
        controller: webViewController,
      )),
    );

    // SafeArea(
    //   child:

    //    Obx(() => Stack(
    //         children: [
    //           // WebViewWidget(
    //           //   controller: controller!,
    //           // ),
    //           WebView(
    //             initialUrl: route!,
    //             debuggingEnabled: true,
    //             // navigationDelegate: (NavigationRequest request) {
    //             //   // if (request.url.contains("https")) {
    //             //   //   launchUrl(Uri.parse(request.url),
    //             //   //       mode: LaunchMode.inAppWebView);
    //             //   //   return NavigationDecision.prevent;
    //             //   // }
    //             //   // return NavigationDecision.navigate;
    //             // },
    //             onWebViewCreated: (WebViewController webViewController) {
    //               innopayDebugPrint("Loaded");
    //               this.webViewController = webViewController;
    //             },
    //             javascriptChannels: {
    //               JavascriptChannel(
    //                   name: 'Print',
    //                   onMessageReceived: (JavascriptMessage message) {
    //                     // debugPrint("Javascript message: ${message.message}");
    //                   })
    //             },
    //             javascriptMode: JavascriptMode.unrestricted,
    //             onPageStarted: (_) {
    //               isLoading = true;
    //               setState(() {});
    //             },
    //             onPageFinished: (_) {
    //               isLoading = false;
    //               setState(() {});
    //             },
    //           ),
    //           // WebView(
    //           //   onPageStarted: (value) {
    //           //     homeController.isWebLoading.value = true;
    //           //   },
    //           //   onPageFinished: (value) {
    //           //     homeController.isWebLoading.value = false;
    //           //   },
    //           //   initialUrl: 'https://epayrent.in/terms-and-conditions',
    //           //   javascriptMode: JavascriptMode.unrestricted,
    //           //   onWebResourceError: (value) {
    //           //     print("error ${value.errorType}");
    //           //   },
    //           //   allowsInlineMediaPlayback: true,
    //           // ),
    //           Visibility(
    //             visible: homeController.isWebLoading.value == true,
    //             child: const Center(
    //               child: CircularProgressIndicator(),
    //             ),
    //           ),
    //           // Align(
    //           //   alignment: Alignment.bottomCenter,
    //           //   child: _bottomButton()),
    //         ],
    //       )),
    // );
  }

  // }
}
