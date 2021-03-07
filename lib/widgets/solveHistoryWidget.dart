import 'dart:math';

import 'package:cubetrainer/model/solve.dart';
import 'package:cubetrainer/model/solveHistory.dart';
import 'package:cubetrainer/model/timerState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SolveHistoryWidget extends StatelessWidget {
  const SolveHistoryWidget({Key key}) : super(key: key);

  String formatSplit(Duration split) =>
      (split.inMilliseconds / 1000.0).toStringAsFixed(2);

  List<Widget> genSolveRow(int width, Solve solve) {
    final DateFormat format = DateFormat.yMd().add_jms();
    return [
      SolveHistoryCell(format.format(solve.timestamp)),
      SolveHistoryCell(solve.scramble),
      ...List.filled(width - solve.splits.length - 2, SolveHistoryCell("-")),
      ...solve.splits.map(formatSplit).map((s) => SolveHistoryCell(s))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<SolveHistoryInterface, SolveState>(
      builder: (_, solveHistory, solveState, __) {
        if (solveState?.currentStatus == CubeStatus.SCRAMBLING &&
            (solveHistory?.solves ?? []).length > 0) {
          List<Solve> solves = solveHistory.solves;
          int gridWidth = solves.map((e) => e.splits.length).reduce(max) + 2;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: gridWidth,
                childAspectRatio: 8,
                children: [...solves.expand((s) => genSolveRow(gridWidth, s))],
              ),
            ),
          );
        } else {
          return Spacer();
        }
      },
    );
  }
}

class SolveHistoryCell extends StatelessWidget {
  final String text;
  const SolveHistoryCell(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(border: Border.all(width: .5)),
        child: Text(text),
        alignment: Alignment.centerLeft,
      ),
    );
  }
}
