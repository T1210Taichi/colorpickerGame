import 'dart:ui';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'game.dart';

List<Map> scores = <Map>[];

class ResultsPage extends StatelessWidget {
  ResultsPage(this.questionColor, this.pickerColor);
  Color questionColor;
  Color pickerColor;

  //questionColorとpickerColorの距離を計算する。
  double calcDistance() {
    String que = toHex(questionColor);
    String pic = toHex(pickerColor);

    String shapeq = que.substring(0, 1);
    int que1 = int.parse(que.substring(1, 3), radix: 16);
    int que2 = int.parse(que.substring(1, 3), radix: 16);
    int que3 = int.parse(que.substring(1, 3), radix: 16);

    String shapep = pic.substring(0, 1);
    int pic1 = int.parse(pic.substring(1, 3), radix: 16);
    int pic2 = int.parse(pic.substring(1, 3), radix: 16);
    int pic3 = int.parse(pic.substring(1, 3), radix: 16);

    double distance =
        sqrt(pow(que1 - pic1, 2) + pow(que2 - pic2, 2) + pow(que3 - pic3, 2));

    storeScore(distance);

    return distance;
  }

  //colorをカラーコードに変換
  String toHex(Color color) {
    final colorStr = color.value.toRadixString(16).toString();
    if (colorStr.length == 8) {
      final hexcolor = colorStr.substring(2);
      final transparent = colorStr.substring(0, 2);
      if (transparent == "ff") {
        return "#" + hexcolor;
      } else {
        return "#" + hexcolor + transparent;
      }
    } else {
      return "#" + colorStr + "00";
    }
  }

  //scoreのカード
  Widget _scoreCard(int index) {
    return Card(
      child: ListTile(
        title: Text("poin\t" + scores[index]["point"]),
        subtitle: Wrap(
          direction: Axis.vertical,
          children: [
            Row(
              children: [
                Text("question\t" + toHex(scores[index]["question"])),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: scores[index]["question"],
                    shape: BoxShape.circle,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text("answer\t" + toHex(scores[index]["answer"])),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: scores[index]["answer"],
                    shape: BoxShape.circle,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  //scoreを格納
  void storeScore(double distance) {
    Map scorelist = {
      "question": questionColor,
      "answer": pickerColor,
      "point": distance.toStringAsFixed(3),
    };
    if (scores.length == 0) {
      scores.add(scorelist);
    } else {
      scores.insert(0, scorelist);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CircleColorPickerGame"),
      ),
      body: Center(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              children: [
                const Gap(10),
                //ポイント表示
                Row(
                  children: [
                    Spacer(
                      flex: 2,
                    ),
                    Text(
                      "Point",
                      style: TextStyle(fontSize: 40),
                    ),
                    Spacer(),
                    Text(
                      calcDistance().toStringAsFixed(3),
                      style: TextStyle(fontSize: 40.0),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                  ],
                ),
                const Gap(10),
                //question answerを表示
                Row(
                  children: [
                    Spacer(
                      flex: 2,
                    ),
                    Text(
                      "Question Color",
                      style: TextStyle(fontSize: 30),
                    ),
                    Spacer(),
                    Text(
                      "Answer Color",
                      style: TextStyle(fontSize: 30),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                  ],
                ),
                const Gap(10),
                //カラーコードを表示
                Row(
                  children: [
                    Spacer(
                      flex: 2,
                    ),
                    Text(
                      toHex(questionColor),
                      style: TextStyle(fontSize: 30),
                    ),
                    Spacer(),
                    Text(
                      toHex(pickerColor),
                      style: TextStyle(fontSize: 30),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                  ],
                ),
                const Gap(10),
                //question anserの色を表示
                Row(
                  children: [
                    Spacer(
                      flex: 2,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: questionColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: pickerColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                  ],
                ),
                Gap(10),
                //戻るボタン
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "もう一度遊ぶ",
                        style: TextStyle(fontSize: 40),
                      )),
                ),
                const Gap(10),
                //得点表示
                Text(
                  "score",
                  style: TextStyle(fontSize: 30),
                ),
                const Gap(10),
                SizedBox(
                  height: 200,
                  child: Scrollbar(
                    child: ListView.builder(
                        itemCount: scores.length,
                        itemBuilder: (context, index) {
                          return _scoreCard(index);
                        }),
                  ),
                ),
                //const Gap(10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
