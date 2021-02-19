import 'package:cubetrainer/model/solve.dart';
import 'package:cubetrainer/model/solveHistory.dart';
import 'package:cubetrainer/model/timerState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SolveHistoryWidget extends StatelessWidget {
  const SolveHistoryWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<SolveHistory, SolveState>(
      builder: (_, solveHistory, solveState, __) {
        if (solveState.currentStatus == CubeStatus.SCRAMBLING) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: ListView.separated(
                itemBuilder: (context, i) => SolveHistoryRow(
                  solveHistory.solves[i],
                  key: Key(i.toString()),
                ),
                separatorBuilder: (context, i) => Divider(),
                itemCount: solveHistory.solves.length,
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

class SolveHistoryRow extends StatelessWidget {
  const SolveHistoryRow(this.solve, {Key key}) : super(key: key);
  final Solve solve;

  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(fontSize: 20);
    final DateFormat dateFormat = DateFormat.yMd().add_jms();

    return Container(
      color: Color.fromARGB(255, 220, 220, 220),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Row(
          children: [
            Text(
              dateFormat.format(solve.timestamp),
              style: style,
            ),
            Text(
              solve.scramble,
              style: style,
              textAlign: TextAlign.center,
            ),
            Text(solve.total.toString(), style: style)
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
}
