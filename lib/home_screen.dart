import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:inkdrop_exporter/notebook/notebook.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  /// ファイルを選択する。
  Future<List<Notebook>> getNotebooks() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result == null) return [];

    final notebooks = result.files.map((e) {
      final json = File(e.path!).readAsStringSync();
      return Notebook.fromJson(jsonDecode(json));
    }).toList();

    return notebooks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'InkdropのメモをMarkdownファイルに変換します。',
            ),
            const SizedBox(height: 16),
            Expanded(
              child: DottedBorder(
                strokeWidth: 4,
                dashPattern: const [8],
                color: Theme.of(context).dividerColor,
                radius: const Radius.circular(16),
                borderType: BorderType.RRect,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('ここにファイルをドラッグ&ドロップしてアップロード'),
                      const SizedBox(height: 32),
                      FilledButton(
                        onPressed: () async {
                          await getNotebooks();
                        },
                        child: const Text('ファイルを選択'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
