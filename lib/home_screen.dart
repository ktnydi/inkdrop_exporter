import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                        onPressed: () {
                          // TODO: ファイルを取得する処理を実装する。
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
