import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:html_to_pdf/html_to_pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prescription/screen/prescription/preview_pdf.dart';
import 'package:prescription/utils/custom_text_wdget.dart';
import 'package:prescription/utils/toast.dart';
import 'package:printing/printing.dart';

import 'html_format.dart';

class PrescriptionInfoScreen extends StatefulWidget {
  const PrescriptionInfoScreen({super.key});

  @override
  State<PrescriptionInfoScreen> createState() => _PrescriptionInfoScreenState();
}

class _PrescriptionInfoScreenState extends State<PrescriptionInfoScreen> {
  HtmlEditorController htmlEditorController = HtmlEditorController();

  String patientInfo = "";
  String doctorInfo = "";
  String otherDetailsInfo = "";

  Future<File> _getPdf(String htmlContent) async {
    Directory appDirectory = await getApplicationDocumentsDirectory();

    final generatedPdfFile = await HtmlToPdf.convertFromHtmlContent(
      htmlContent: getHtmlContentFull(doctorInfo, otherDetailsInfo, patientInfo),
      printPdfConfiguration: PrintPdfConfiguration(
        targetDirectory: appDirectory.path,
        targetName: 'document',
        printSize: PrintSize.A4,
        printOrientation: PrintOrientation.Portrait,
      ),
    );
    return generatedPdfFile;
  }

  void printRx(Uint8List data) async {
    await Printing.layoutPdf(onLayout: (_) => data);
  }

  Future<void> _showEdit(BuildContext context, int boxNumber) async {
    String currentContent = "";

    // Determine the content to load based on the box number
    if (boxNumber == 3) {
      currentContent = patientInfo;
    } else if (boxNumber == 1) {
      currentContent = doctorInfo;
    } else if (boxNumber == 2) {
      currentContent = otherDetailsInfo;
    }

    htmlEditorController.setText(currentContent);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(5.0)),
      ),
      builder: (context) => SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Editor Area
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: HtmlEditor(
                      controller: htmlEditorController,
                      htmlEditorOptions: HtmlEditorOptions(initialText: currentContent, hint: 'Type here'),
                      htmlToolbarOptions: HtmlToolbarOptions(
                        toolbarPosition: ToolbarPosition.belowEditor,
                        toolbarType: ToolbarType.nativeScrollable,
                        defaultToolbarButtons: [
                          StyleButtons(),
                          FontButtons(
                              bold: true,
                              italic: true,
                              underline: true,
                              clearAll: false,
                              superscript: false,
                              subscript: false),
                          FontSettingButtons(
                            fontName: false,
                            fontSize: true,
                            fontSizeUnit: false,
                          ),
                          ParagraphButtons(
                              lineHeight: true,
                              caseConverter: false,
                              increaseIndent: false,
                              decreaseIndent: false,
                              textDirection: false)
                        ],
                        onButtonPressed: (ButtonType type, bool? status, Function? updateStatus) {
                          print("button '${describeEnum(type)}' pressed, the current selected status is $status");
                          return true;
                        },
                        onDropdownChanged: (DropdownType type, dynamic changed, Function(dynamic)? updateSelectedItem) {
                          print("dropdown '${describeEnum(type)}' changed to $changed");
                          return true;
                        },
                        mediaLinkInsertInterceptor: (String url, InsertFileType type) {
                          print(url);
                          return true;
                        },
                        mediaUploadInterceptor: (PlatformFile file, InsertFileType type) async {
                          print(file.name);
                          print(file.size);
                          print(file.extension);
                          return true;
                        },
                      ),
                      otherOptions: OtherOptions(height: 550),
                      callbacks: Callbacks(onBeforeCommand: (String? currentHtml) {
                        print('html before change is $currentHtml');
                      }, onChangeContent: (String? changed) {
                        print('content changed to $changed');
                      }, onChangeCodeview: (String? changed) {
                        print('code changed to $changed');
                      }, onChangeSelection: (EditorSettings settings) {
                        print('parent element is ${settings.parentElement}');
                        print('font name is ${settings.fontName}');
                      }, onDialogShown: () {
                        print('dialog shown');
                      }, onEnter: () {
                        print('enter/return pressed');
                      }, onFocus: () {
                        print('editor focused');
                      }, onBlur: () {
                        print('editor unfocused');
                      }, onBlurCodeview: () {
                        print('codeview either focused or unfocused');
                      }, onInit: () {
                        print('init');
                      }, onImageUploadError: (FileUpload? file, String? base64Str, UploadError error) {
                        print(describeEnum(error));
                        print(base64Str ?? '');
                        if (file != null) {
                          print(file.name);
                          print(file.size);
                          print(file.type);
                        }
                      }, onKeyDown: (int? keyCode) {
                        print('$keyCode key downed');
                        print('current character count: ${htmlEditorController.characterCount}');
                      }, onKeyUp: (int? keyCode) {
                        print('$keyCode key released');
                      }, onMouseDown: () {
                        print('mouse downed');
                      }, onMouseUp: () {
                        print('mouse released');
                      }, onNavigationRequestMobile: (String url) {
                        print(url);
                        return NavigationActionPolicy.ALLOW;
                      }, onPaste: () {
                        print('pasted into editor');
                      }, onScroll: () {
                        print('editor scrolled');
                      }),
                      plugins: [
                        SummernoteAtMention(
                            getSuggestionsMobile: (String value) {
                              var mentions = <String>['test1', 'test2', 'test3'];
                              return mentions.where((element) => element.contains(value)).toList();
                            },
                            mentionsWeb: ['test1', 'test2', 'test3'],
                            onSelect: (String value) {
                              print(value);
                            }),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        htmlEditorController.clear(); // Close the bottom sheet
                      },
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: const Icon(Icons.refresh, color: Colors.white),
                      ),
                      label: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: const Text(
                          'Reset',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        String? content = await htmlEditorController.getText();
                        if (content.trim().isNotEmpty) {
                          setState(() {
                            if (boxNumber == 3) {
                              patientInfo = content;
                            } else if (boxNumber == 1) {
                              doctorInfo = content;
                            } else if (boxNumber == 2) {
                              otherDetailsInfo = content;
                            }
                          });
                          Navigator.pop(context); // Close the bottom sheet or dialog
                        } else {
                          Toast.showErrorToast(
                            "Empty field",
                          );
                        }
                      },
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: const Icon(Icons.save, color: Colors.white),
                      ),
                      label: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    /*Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              htmlEditorController.clear(); // Close the bottom sheet
                            },
                            icon: const Icon(Icons.refresh, color: Colors.white),
                            label: const Text(
                              'Reset',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () async {
                              String? content = await htmlEditorController.getText();
                              if (content.isNotEmpty) {
                                setState(() {
                                  if (boxNumber == 3) {
                                    patientInfo = content;
                                  } else if (boxNumber == 1) {
                                    doctorInfo = content;
                                  } else if (boxNumber == 2) {
                                    otherDetailsInfo = content;
                                  }
                                });
                                Navigator.pop(context); // Close the bottom sheet
                              }
                            },
                            icon: const Icon(Icons.save, color: Colors.white),
                            label: const Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),*/
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(200, 100, 100, 200),
        actions: [
          IconButton(
            onPressed: () async {
              final pdfFile = await _getPdf(patientInfo + doctorInfo + otherDetailsInfo);
              Navigator.of(context).push(CupertinoPageRoute(
                builder: (_) => PdfPreviewScreen(
                  pdfFile: pdfFile,
                ),
              ));
            },
            icon: const Icon(
              Icons.picture_as_pdf_sharp,
              color: Colors.white,
            ),
          ),
        ],
        title: const Text(
          'Prescription',
          style: TextStyle(fontFamily: 'NotoSans', fontSize: 24.5, fontWeight: FontWeight.w900, color: Colors.white),
        ),
      ),
      body: Container(
        color: Color(0xFFFFF8E1).withOpacity(.2),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Container(
                        width: width,
                        //height: height * 0.3,
                        decoration: BoxDecoration(
                            border: Border(
                          top: BorderSide(color: Colors.black45, width: 1), // Top border
                          right: BorderSide(color: Colors.black45, width: 1),
                          //bottom: BorderSide(color: Colors.black45, width: .5),
                        )),
                        child: TextButton(
                          onPressed: () => _showEdit(context, 1),
                          child: doctorInfo.isEmpty ? Text('+ Add Doctor Information') : HtmlWidget(doctorInfo),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Divider(thickness: 2),
                    Flexible(
                      child: Container(
                        width: width,
                        //height: height * 0.3,
                        decoration: BoxDecoration(
                            border: Border(
                          top: BorderSide(color: Colors.black45, width: 1), // Top border
                          left: BorderSide(color: Colors.black45, width: 1),
                          //bottom: BorderSide(color: Colors.black45, width: .5),
                        )),
                        child: TextButton(
                          onPressed: () => _showEdit(context, 2),
                          child:
                              otherDetailsInfo.isEmpty ? Text('+ Add Other Information') : HtmlWidget(otherDetailsInfo),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Divider(thickness: 2),
                Container(
                  width: width,
                  //height: height * 0.1,
                  decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
                  child: TextButton(
                    onPressed: () => _showEdit(context, 3),
                    child: patientInfo.isEmpty ? Text('+ Add Patient Information') : HtmlWidget(patientInfo),
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Flexible(
                      child: Container(
                          width: width,
                          height: height * 0.5,
                          decoration: BoxDecoration(
                              border: Border(
                            top: BorderSide(color: Colors.black45, width: 1.5), // Top border
                            right: BorderSide(color: Colors.black45, width: 1),
                          )), // Right border
                          // No left or bottom borders
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextWidget(
                                  title: 'Owners Complaint',
                                  subtitle: 'Complaints',
                                  description: 'Remarks',
                                ),
                                SizedBox(height: 12),
                                CustomTextWidget(
                                  title: 'Clinical Findings',
                                  subtitle: 'Complaints',
                                  description: 'Remarks',
                                ),
                                SizedBox(height: 12),
                                CustomTextWidget(
                                  title: 'Postmortem Findings',
                                  subtitle: 'Complaints',
                                  description: 'Remarks',
                                ),
                                SizedBox(height: 12),
                                CustomTextWidget(
                                  title: 'Diagnosis',
                                  subtitle: 'Complaints',
                                  description: 'Remarks',
                                ),
                              ],
                            ),
                          )),
                    ),
                    Flexible(
                      child: Container(
                        width: width,
                        height: height * 0.5,
                        decoration: BoxDecoration(
                            border: Border(
                          top: BorderSide(color: Colors.black45, width: 1.5), // Top border
                          left: BorderSide(color: Colors.black45, width: 1),
                        )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextWidget(
                                title: 'Rx',
                                subtitle: 'Complaints',
                                description: 'Remarks',
                              ),
                              SizedBox(height: 12),
                              CustomTextWidget(
                                title: 'Advice',
                                subtitle: 'Complaints',
                                description: 'Remarks',
                              ),
                              SizedBox(height: 12),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
