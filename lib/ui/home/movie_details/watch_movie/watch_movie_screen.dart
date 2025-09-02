import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WatchMovieScreen extends StatefulWidget {
  const WatchMovieScreen({super.key});

  @override
  State<WatchMovieScreen> createState() => _WatchMovieScreenState();
}

class _WatchMovieScreenState extends State<WatchMovieScreen> {
  WebViewController? _controller;
  late String movieUrl;
  bool _isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final url=movieUrl;
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate( 
            onPageFinished: (_) {
              setState(() => _isLoading = false);
            },
          ),
        )
        ..loadRequest(Uri.parse(url));
        setState(() {});
    },);
  }
  @override
  Widget build(BuildContext context) {
    movieUrl=ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      body:_controller==null?Center(child: CircularProgressIndicator()):
      Stack(
        children: [
          WebViewWidget(controller: _controller!,),
          if(_isLoading)Center(child: CircularProgressIndicator(),)
        ],
      ) ,
    );
  }
}