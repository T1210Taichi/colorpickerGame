import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math';
import 'game.dart';

void main() => runApp(MyApp());

class AppTheme {
  static ThemeData defualt(BuildContext context) {
    return ThemeData(
      fontFamily: "Noto_Sans_JP",
      primaryColor: Colors.blue,
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        //ターゲットデバイスの設定
        designSize: const Size(375, 812),
        //幅と高さの最小値に応じてテキストサイズを可変させるか
        minTextAdapt: true,
        //split screenに対応するかどうか
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: "CicleColorPickerGamer",
            theme: AppTheme.defualt(context),
            home: HomePage(),
          );
        });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CircleColorPickerGame"),
      ),
      body: Center(
        child: Center(
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  "Circle Color Picker Gameとは？",
                  style: TextStyle(fontSize: 60),
                ),
              ),
              Text("出題されるカラーコードから色を推測する色あてゲームです"),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  "カラーコードとは？",
                  style: TextStyle(fontSize: 60),
                ),
              ),
              Text(
                  "2桁の16進数、3組でそれぞれがR(赤)、G(緑)、B(青)を表す。\n ex) #000000は黒、#ffffffは白、#ff0000は赤を表す。"),
              Spacer(),
              SizedBox(
                width: 500,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => GamePage()));
                    },
                    child: Text(
                      "Game Start",
                      style: TextStyle(fontSize: 40),
                    )),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
