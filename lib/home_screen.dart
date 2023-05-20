import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:inkdrop_exporter/extensions/build_context.dart';
import 'package:inkdrop_exporter/notebook/notebook.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<void> download({required List<Notebook> notebooks}) async {
    final tmpDir = await getTemporaryDirectory();
    final dir = Directory(join(tmpDir.path, 'inkdrop'));

    if (dir.existsSync()) {
      dir.deleteSync(recursive: true);
      dir.createSync(recursive: true);
    }

    for (var notebook in notebooks) {
      if (notebook.title.isEmpty && notebook.body.isEmpty) {
        continue;
      }

      final filePath = join(dir.path, '${notebook.id}.md');
      final file = File(filePath);
      file.createSync(recursive: true);
      file.writeAsStringSync(
        '# ${notebook.title}\n'
        '\n'
        '${notebook.body}',
      );
    }

    final encoder = ZipFileEncoder();
    encoder.create(join(tmpDir.path, 'inkdrop.zip'));
    encoder.addDirectory(dir);
    encoder.close();

    await FileSaver.instance.saveFile(
      name: 'inkdrop',
      filePath: encoder.zipPath,
      ext: 'zip',
    );
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
                          final notebooks = await getNotebooks();

                          await download(notebooks: notebooks);

                          // ignore: use_build_context_synchronously
                          if (!context.mounted) return;

                          context.showSnackBar(
                            content: const Text('ダウンロードフォルダに保存しました。'),
                          );
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
