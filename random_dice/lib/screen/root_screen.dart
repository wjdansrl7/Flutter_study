
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_dice/screen/home_screen.dart';
import 'package:random_dice/screen/setting_screen.dart';
import 'package:shake/shake.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RootScreenState();

}

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: TabBarView( // 탭 화면을 보여줄 위젯
  //       children: renderChildren(),
  //     ),
  //
  //     // 아래 탭 내비게이션ㅇ르 구현하는 매개변수
  //     bottomNavigationBar: renderBottomNavigation(),
  //   );
  // }
  //
  // List<Widget> renderChildren() {
  //   return [];
  // }
  //
  // BottomNavigationBar renderBottomNavigation() {
  //   // 탭 내비게이션을 구현하는 위젯
  //   return BottomNavigationBar(items: []);
  //
  // }
// }

// TickerProviderStateMixin 사용하기
class _RootScreenState extends State<RootScreen> with
    TickerProviderStateMixin {
  TabController? controller; // 사용할 TabController 선언
  double threshold = 2.7; // 민감도의 기본값 설정
  int number = 1;
  ShakeDetector? shakeDetector;


  @override
  void initState() {
    super.initState();

    controller = TabController(length: 2, vsync: this); // 컨트롤러 초기화하기

    // 컨트롤러 속성이 변경될 때마다 실행할 함수 등록
    controller!.addListener(tabListener);

    shakeDetector = ShakeDetector.autoStart(
      shakeSlopTimeMS: 100, // 감지 주기
      shakeThresholdGravity: threshold, // 감지 민감도
      onPhoneShake: onPhoneShake, // 감지 후 실행할 함수
    );
  }

  void onPhoneShake() { // 감지 후 실행할 함수
    final rand = new Random();

    setState(() {
      number = rand.nextInt(5) + 1;
    });


  }

    tabListener() { // 리스너로 사용할 함수
      setState(() {});
  }

  @override
  void dispose() {
    controller!.removeListener(tabListener); // 리스너에 등록한 함수 등록 취소
    shakeDetector!.stopListening(); // 흔들기 감지 중지

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: renderChildren(),
      ),
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  List<Widget> renderChildren() {
    return [
      // Container(
      //   child: Center(
      //     child: Text(
      //       'Tab 1',
      //       style: TextStyle(
      //         color: Colors.white,
      //       ),
      //     ),
      //   ),
      // ),
      HomeScreen(number: number),
      SettingScreen(
          threshold: threshold,
          onThresholdChange: onThresholdChange,
      ),
      // Container(
      //   child: Center(
      //     child: Text(
      //       'Tab 2',
      //       style: TextStyle(
      //         color: Colors.white,
      //       ),
      //     ),
      //   ),
      // )
    ];
  }

  // 슬라이더값 변경 시 실행 함수
  void onThresholdChange(double val) {
    setState(() {
      threshold = val;
    });
  }

  BottomNavigationBar renderBottomNavigation() {
  // 탭 내비게이션을 구현하는 위젯
    return BottomNavigationBar(
      // 현재 화면에 렌더링되는 탭의 인덱스
      currentIndex: controller!.index,
      onTap: (int index) { // 탭이 선택될 때마다 실행되는 함수
        setState(() {
          controller!.animateTo(index);
        });
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.edgesensor_high_outlined,
        ),
          label: '주사위',
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
        ),
          label: '설정',
        ),
      ],
    );
  }
}