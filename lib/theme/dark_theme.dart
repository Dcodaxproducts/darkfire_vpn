import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

ThemeData dark({Color color = primaryColor}) => ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      primaryColor: color,
      secondaryHeaderColor: const Color(0xFF009f67),
      disabledColor: const Color(0xffa2a7ad),
      scaffoldBackgroundColor: backgroundColorDark,
      brightness: null,
      hintColor: const Color(0xFFA4A6A4),
      cardColor: cardColorDark,
      dividerColor: Colors.grey[800]!,
      shadowColor: shadowColorDark,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: color),
      ),
      colorScheme:
          ColorScheme.fromSeed(seedColor: color, secondary: color).copyWith(
        error: const Color(0xFFdd3135),
        outline: const Color(0xFF2C2C2C),
      ),
      iconTheme: IconThemeData(color: Colors.white, size: 24.sp),
      textTheme: GoogleFonts.poppinsTextTheme(
        TextTheme(
          displayLarge: TextStyle(
            fontSize: 30.sp,
            color: textColordark,
            fontFamily: 'Poppins',
          ),
          displayMedium: TextStyle(
            fontSize: 24.sp,
            color: textColordark,
            fontFamily: 'Poppins',
          ),
          displaySmall: TextStyle(
            fontSize: 20.sp,
            color: textColordark,
            fontFamily: 'Poppins',
          ),
          headlineMedium: TextStyle(
            fontSize: 18.sp,
            color: textColordark,
            fontFamily: 'Poppins',
          ),
          bodyLarge: TextStyle(
            fontSize: 16.sp,
            color: textColordark,
            fontFamily: 'Poppins',
          ),
          bodyMedium: TextStyle(
            fontSize: 14.sp,
            color: textColordark,
            fontFamily: 'Poppins',
          ),
          bodySmall: TextStyle(
            fontSize: 12.sp,
            color: textColordark,
            fontFamily: 'Poppins',
          ),
          titleMedium: TextStyle(
            fontSize: 10.sp,
            color: textColordark,
            fontFamily: 'Poppins',
          ),
          titleSmall: TextStyle(
            fontSize: 8.sp,
            color: textColordark,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 10.sp,
        color: backgroundColorDark,
        surfaceTintColor: backgroundColorDark,
        shadowColor: backgroundColorDark,
        iconTheme: IconThemeData(color: Colors.white, size: 24.sp),
        titleTextStyle:
            GoogleFonts.poppins(fontSize: 22.sp, color: textColordark),
        centerTitle: false,
      ),
    );
