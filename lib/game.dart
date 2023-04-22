// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:math' as math;
import 'package:gap/gap.dart';

import './main.dart';
import './results.dart';

//色を設定
Color pickerColor = Color(0xff443a49);
Color currentColor = Color(0xff443a49);
Color questionColor = Color(0xffffff);

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

//乱数作成
  Color randomColor() {
    return Color(
      (math.Random().nextDouble() * 0xFFFFFF).toInt() << 0,
    ).withOpacity(1.0);
  }

  //問題をセット
  void makeQuestion() {
    //乱数から問題作成
    setState(() {
      questionColor = randomColor();
    });
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

  @override
  void initState() {
    makeQuestion();
  }

  @override
  Widget build(BuildContext context) {
    //画面のサイズ取得
    var _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("CircleColorPickerGame"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(10),
              //問題を表示
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    const Gap(10),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        toHex(questionColor),
                        style: TextStyle(
                          fontSize: 90,
                        ),
                      ),
                    ),
                    const Gap(10),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                        ),
                        onPressed: () {
                          setState(() {
                            makeQuestion();
                          });
                        },
                        child: Icon(Icons.cached),
                      ),
                    ),
                    const Gap(10),
                  ],
                ),
              ),
              const Gap(10),
              //カラーピッカー
              Row(
                children: [
                  Spacer(),
                  Container(
                    width: _screenSize.width * 0.7,
                    child: SlidePicker(
                      pickerColor: pickerColor,
                      onColorChanged: changeColor,
                      colorModel: ColorModel.rgb,
                      enableAlpha: false,
                      showParams: false,
                      showIndicator: true,
                      indicatorBorderRadius:
                          const BorderRadius.vertical(top: Radius.circular(25)),
                    ),
                  ),
                  Spacer(),
                ],
              ),
              //
              const Gap(10),
              //提出ボタン
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ResultsPage(questionColor, pickerColor);
                      })).then(
                        //帰ってきたら
                        (value) {
                          makeQuestion();
                        },
                      );
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 40),
                    )),
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}
