import 'package:flutter/material.dart';
import 'package:u_and_i/screen/home_screen.dart';

// Cupertino Widget, CupertinoDatePicker
// Dialog, StatefulWidget 상태관리
void main() {
  runApp(MaterialApp(
    theme: ThemeData( // 테마를 지정할 수 있는 클래스
      fontFamily: 'sunflower', // 기본 글씨체
      textTheme: TextTheme( //글자 테마를 적용할 수 있는 클래스
        displayLarge: TextStyle( // headline1 스타일 정의
          color: Colors.white, // 글색상
          fontSize: 80, // 크기
          fontWeight: FontWeight.w700, // 글 두께
          fontFamily: 'parisienne', // 글씨체
        ),
        displayMedium: TextStyle(
          color: Colors.white,
          fontSize: 50,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
        bodyMedium: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      )
    ),
    home: HomeScreen(),
    ),
  );
}