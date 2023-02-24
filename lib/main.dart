import 'dart:io';

import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    late WebViewController mywebcontroller;

    return WillPopScope(
      onWillPop: () async {
        if (await mywebcontroller.canGoBack()) {
          mywebcontroller.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: WebView(
            onWebViewCreated: (controller) {
              mywebcontroller = controller;
            },
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: "https://morethanjustgames.com/",
          ),
        ),
      ),
    );
  }
}
