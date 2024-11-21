import 'dart:io';
import 'dart:math';

import 'package:downloadsfolder/downloadsfolder.dart';
import 'package:flutter/material.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prescription/utils/colors.dart';
import 'package:prescription/utils/navigation_item.dart';
import 'package:share_plus/share_plus.dart';

import '../../utils/toast.dart';

class PdfPreviewScreen extends StatefulWidget {
  final File pdfFile;

  PdfPreviewScreen({required this.pdfFile});

  @override
  State<PdfPreviewScreen> createState() => _PdfPreviewScreenState();
}

class _PdfPreviewScreenState extends State<PdfPreviewScreen> {
  Future<void> downloadRx(String fileName, File sourceFile) async {
    // storage permission ask
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    final packageInfo = await PackageInfo.fromPlatform()
      ..appName;
    final downloadDir = await getDownloadDirectory();
    final localPath = Platform.isAndroid ? '${downloadDir.path}/${packageInfo.appName}' : downloadDir.path;

    // create folder
    final savedDir = Directory(localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) savedDir.create();

    // save the file
    final file = File('$localPath/RX-$fileName.pdf');

    if (await sourceFile.exists()) {
      await sourceFile.copy(file.path);
      MediaScanner.loadMedia(path: file.path);

      final filePath = '"/Downloads/${packageInfo.appName}/RX-$fileName.pdf"';
      Toast.showSuccessToast('Successfully download $filePath');
    } else {
      print('Source file does not exist');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(200, 100, 100, 200),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Handle back button press
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Prescription view',
          style: TextStyle(
            fontFamily: 'NotoSans',
            fontSize: 24.5,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        centerTitle: true, // Centers the title in the AppBar
      ),
      body: Container(
        color: Colors.grey[200], // Replace with AppColors.kBackgroundColor.
        padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
        child: PdfViewer.openFile(
          widget.pdfFile.path,
          params: PdfViewerParams(
            pageDecoration: const BoxDecoration(),
            layoutPages: (viewSize, pages) {
              List<Rect> rect = [];
              final viewWidth = viewSize.width;
              final viewHeight = viewSize.height;
              final maxWidth = pages.fold<double>(0.0, (maxWidth, page) => max(maxWidth, page.width));
              final ratio = viewWidth / maxWidth;
              var top = 0.0;
              for (var page in pages) {
                final width = page.width * ratio;
                final height = page.height * ratio;
                final left = viewWidth > viewHeight ? (viewWidth / 2) - (width / 2) : 0.0;
                rect.add(Rect.fromLTWH(left, top, width, height));
                top += height + 8;
              }
              return rect;
            },
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.kCardColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                color: Colors.grey.withOpacity(0.15),
                offset: const Offset(0, -2.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LayoutBuilder(
                builder: (_, constraints) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: constraints.maxWidth),
                      child: IntrinsicWidth(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            NavigationItem(
                              label: 'Share',
                              icon: Icon(Icons.share),
                              onPressed: () {
                                Share.shareXFiles([XFile(widget.pdfFile.path, mimeType: 'application/pdf')]);
                              },
                            ),
                            NavigationItem(
                              label: 'Download',
                              icon: Icon(Icons.download),
                              onPressed: () {
                                downloadRx('123ABC', widget.pdfFile);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
