import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsView extends StatefulWidget {
  final String newsUrl;

  NewsView({this.newsUrl});

  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Br",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w800,
                color: Colors.blue[900],
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 3.0),
                    blurRadius: 3.0,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Text(
              "ita",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w800,
                color: Colors.white,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 3.0),
                    blurRadius: 3.0,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Text(
              "in",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w800,
                color: Colors.red,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 3.0),
                    blurRadius: 3.0,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              "Express",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          Opacity(
            opacity: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.assessment_outlined),
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.newsUrl,
          onWebViewCreated: ((WebViewController webViewController) {
            _completer.complete(webViewController);
          }),
        ),
      ),
    );
  }
}
