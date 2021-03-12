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

  List<DataColumn> calculateColumns(List<Solve> solves) {
    int nSplits = solves.map((s) => s.splits.length).reduce(max);
    return [
      DataColumn(label: Text("Date")),
      DataColumn(label: Text("Scramble")),
      ...List<DataColumn>.generate(
              nSplits, (index) => DataColumn(label: Text("Split ${index + 1}")))
          .toList(),
      DataColumn(label: Text("Total")),
    ];
  }

  String formatDuration(Duration d) =>
      ((d.inMilliseconds) / 1000).toStringAsFixed(3);

  DataRow dataRowForSolve(Solve solve, int nColumns) {
    final DateFormat format = DateFormat.yMd().add_jms();
    final List<DataCell> splitCells = solve.splits
        .map(formatDuration)
        .map((s) => DataCell(Text(s, textAlign: TextAlign.center)))
        .toList();
    final List<DataCell> fillerCells =
        List.generate(nColumns - splitCells.length - 3, (_) => DataCell.empty);
    final List<DataCell> cells = [
      DataCell(Text(format.format(solve.timestamp))),
      DataCell(LimitedBox(
        maxWidth: 5,
        child: Text(
          solve.scramble,
          overflow: TextOverflow.ellipsis,
        ),
      )),
      ...fillerCells,
      ...splitCells,
      DataCell(Text(formatDuration(solve.total)))
    ];
    print("cells len: ${cells.length}");

    return DataRow(cells: cells);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<SolveHistoryInterface, SolveState>(
      builder: (_, solveHistory, solveState, __) {
        if (solveState?.currentStatus == CubeStatus.SCRAMBLING &&
            (solveHistory?.solves ?? []).length > 0) {
          List<Solve> solves = solveHistory.solves;
          List<DataColumn> columns = calculateColumns(solves);
          return Expanded(
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: DataTable(
                  columns: columns,
                  rows: solves
                      .map((s) => dataRowForSolve(s, columns.length))
                      .toList(),
                ),
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
