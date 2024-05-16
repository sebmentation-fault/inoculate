
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:inoculate/constants/markdown_styles.dart';

/// Widget that shows a confusion matrix
/// 
/// * True positive - number of questions that should be "accurate" and were answered "accurate"
/// * False positive - number of questions that should be "fake" but were answered "accurate"
/// * True negative - number of questions that should be "accurate" but were answered "fake"
/// * False negative - number of questions that should be "fake" and were answered "fake"
class ConfusionMatrix extends StatelessWidget {
  final int truePositiveCount;
  final int falsePositiveCount;
  final int trueNegativeCount;
  final int falseNegativeCount;

  final double squareSize = 200;

  const ConfusionMatrix(this.truePositiveCount, this.falsePositiveCount, this.trueNegativeCount, this.falseNegativeCount, {super.key});

  @override
  Widget build(BuildContext context) {
    int total = truePositiveCount + trueNegativeCount + falsePositiveCount + falseNegativeCount;
    double tpIntensity = truePositiveCount / total;
    double fpIntensity = falsePositiveCount / total;
    double tnIntensity = trueNegativeCount / total;
    double fnIntensity = falseNegativeCount / total;
    return Column(
      children: [
        MarkdownBody(
          data: "# Confusion Matrix", 
          styleSheet: getMarkdownStyle(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // True Positive
            Container(
              width: squareSize,
              height: squareSize,
              color: Colors.green.withOpacity(tpIntensity),
              child: Center(child: Text("$truePositiveCount TP", style: const TextStyle(fontSize: 24),)),
            ),
            // False Negative
            Container(
              width: squareSize,
              height: squareSize,
              color: Colors.red.withOpacity(fnIntensity),
              child: Center(child: Text("$falseNegativeCount FN", style: const TextStyle(fontSize: 24),)),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // False Positive
            Container(
              width: squareSize,
              height: squareSize,
              color: Colors.red.withOpacity(fpIntensity),
              child: Center(child: Text("$falsePositiveCount FP", style: const TextStyle(fontSize: 24),)),
            ),
            // True Negative
            Container(
              width: squareSize,
              height: squareSize,
              color: Colors.green.withOpacity(tnIntensity),
              child: Center(child: Text("$trueNegativeCount TN", style: const TextStyle(fontSize: 24),)),
            ),
          ],
        ),
        const SizedBox(height: 48,),
        const MarkdownBody(data: "Key:\n\n* TP - **correctly** selected an accurate headline\n\n* FP - **incorrectly** selected an accurate headline\n\n* TN - **correctly** selected an fake headline\n\n* TP - **incorrectly** selected an accurate headline"),
      ],
    );
  }
}