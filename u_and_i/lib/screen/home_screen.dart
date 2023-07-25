
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.pink[100], // 핑크 배경색 적용
//       body: SafeArea( // 시스템 UI 피해서 UI 그리기
//         top: true,
//         bottom: false,
//         child: Column(
//           // 위 아래 끝에 위젯 배치
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//
//           // 반대축 최대 크기로 늘리기
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             _DDay(),
//             _CoupleImage(),
//           ],
//         ),
//       ),
//     );
//   }
// }

class _HomeScreenState extends State<HomeScreen>{
  DateTime firstDay = DateTime.now();

  void onHeartPressed() {

    showCupertinoDialog( // 2. 쿠퍼티노 다이얼로그 실행
        context: context, // 3. 보여줄 다이얼로그 빌드
        builder: (BuildContext context) {
          // 4. 날짜 선택하는 다이얼로그
          return Align( // 정렬을 지정하는 위젯
            alignment: Alignment.bottomCenter, // 아래 중간으로 정렬
            child: Container(
              color: Colors.white, // 배경색 흰색 지정
              height: 300, // 높이 300 지정
              child: CupertinoDatePicker(
              // 5. 시간 제외하고 날짜만 선택하기
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime date) {
                setState(() {
                  firstDay = date;
                });
              },
              ),
            ),
          );
        },
      barrierDismissible: true, // 외부 탬할 경우 다이얼로그 닫기
    );

    // 상태 변경 시 setState() 함수 실행
    // setState(() {
    //   // firstDay 변수에서 하루 빼기
    //   firstDay = firstDay.subtract(Duration(days: 1));
    //
    // });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DDay(
              // 5. 하트 눌렀을 때 실행할 함수 전달하기
              onHeartPressed: onHeartPressed,
              firstDay: firstDay,
            ),
            _CoupleImage(),
          ],
        ),
      ),
    );
  }
  // void onHeartPressed() { // 4. 하트 눌렀을 때 실행할 함수
  //   print('클릭');
  // }
}


class _DDay extends StatelessWidget{
  // 1. 하트 눌렀을 때 실행할 함수
  final GestureTapCallback onHeartPressed;
  final DateTime firstDay; // 1. 사귀기 시작한 날

  _DDay({
    required this.onHeartPressed, // 2. 상위에서 함수 입력 받기
    required this.firstDay, // 2. 날짜 변수로 입력받기
  });

  @override
  Widget build(BuildContext context) {
    // 테마 불러오기
    final textTheme = Theme.of(context).textTheme;
    final now = DateTime.now();

    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          'U&I',
          style: textTheme.displayLarge,
        ),
        const SizedBox(height: 16),
        Text(
          '우리 처음 만난 날',
          style: textTheme.bodyLarge,
        ),
        Text(
          // '2021.11.23',
          // DateTime을 년.월.일 형태로 변경
          '${firstDay.year}.${firstDay.month}.${firstDay.day}',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        IconButton(
            iconSize: 60,
            onPressed: onHeartPressed, // 3. 아이콘 눌렀을 때 실행할 함수
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
        ),
      const SizedBox(height: 16),
      Text( // 만난 후 DDay
        // 'D+365',
        // DDay 계산하기
        'D+${DateTime(now.year, now.month, now.day).difference(firstDay).inDays + 1}',
        // 'D-${firstDay.difference(DateTime(now.year, now.month, now.day)).inDays}',
        style: textTheme.displayMedium,
      ),
      ],
    );
  }
}

class _CoupleImage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center( // 이미지 중앙 정렬
        child: Image.asset(
        'asset/img/middle_image.png',

      // Expanded가 우선순위를 갖게 되어 무시됩니다.
      //  화면의 반만큼 높이 구현
        height: MediaQuery.of(context).size.height / 2,
      ),
    ),
    );
  }


}

