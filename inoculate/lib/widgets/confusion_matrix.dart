
import 'package:flutter/material.dart';

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
        const Text("Confusion Matrix Visualization"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // True Positive
            Container(
              width: 100,
              height: 100,
              color: Colors.green.withOpacity(tpIntensity),
              child: Center(child: Text("$truePositiveCount TP")),
            ),
            // False Negative
            Container(
              width: 100,
              height: 100,
              color: Colors.red.withOpacity(fnIntensity),
              child: Center(child: Text("$falseNegativeCount FN")),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // False Positive
            Container(
              width: 100,
              height: 100,
              color: Colors.red.withOpacity(fpIntensity),
              child: Center(child: Text("$falsePositiveCount FP")),
            ),
            // True Negative
            Container(
              width: 100,
              height: 100,
              color: Colors.green.withOpacity(tnIntensity),
              child: Center(child: Text("$trueNegativeCount TN")),
            ),
          ],
        ),
      ],
    );
  }
}