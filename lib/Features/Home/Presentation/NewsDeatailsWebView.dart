import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:newsapp/Core/utils/widgets/VerticalSpacing.dart';
import 'package:newsapp/Features/Home/Presentation/Manger/HomeCubit.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailsWebView extends StatefulWidget {
  const NewsDetailsWebView({super.key, required this.url});
  final String url;
  @override
  State<NewsDetailsWebView> createState() => _NewsDetailsWebViewState();
}

class _NewsDetailsWebViewState extends State<NewsDetailsWebView> {
  late final WebViewController _webcontroller;
  double onprogress = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _webcontroller.canGoBack()) {
          _webcontroller.goBack();
          // stay inside
          return true;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(IconlyLight.arrowLeft2),
            ),
            iconTheme: IconThemeData(
                color: HomeCubit.getobject(context).isDark
                    ? Colors.white
                    : Colors.black),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            centerTitle: true,
            title: Text(
              widget.url,
              style: TextStyle(
                  color: HomeCubit.getobject(context).isDark
                      ? Colors.white
                      : Colors.black),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  await _showModalSheet();
                },
                icon: const Icon(
                  Icons.more_horiz,
                ),
              ),
            ]),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: onprogress,
              color: onprogress == 1 ? Colors.transparent : Colors.blue,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            Flexible(
              child: WebView(
                initialUrl: widget.url,
                zoomEnabled: true,
                onWebViewCreated: (controller) {
                  _webcontroller = controller;
                },
                onProgress: (progress) {
                  onprogress = progress / 100;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showModalSheet() async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const VerticalSpacing(20),
              Center(
                child: Container(
                  height: 5,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const VerticalSpacing(20),
              const Text(
                'More Options',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              const VerticalSpacing(20),
              const Divider(
                thickness: 2,
              ),
              const VerticalSpacing(20),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Share'),
                onTap: () {
                  try {
                    Share.share(
                      widget.url,
                      subject: 'Look what I made!',
                    );
                  } catch (e) {
                    log(e.toString());
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.open_in_browser),
                title: const Text('Open in browser'),
                onTap: () async {
                  if (!await launchUrl(Uri.parse(widget.url))) {
                    throw Exception('Could not launch ${widget.url}');
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.refresh),
                title: const Text('Refresh'),
                onTap: () async {
                  try {
                    await _webcontroller.reload();
                  } catch (e) {
                    log(e.toString());
                  } finally {
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }
}
