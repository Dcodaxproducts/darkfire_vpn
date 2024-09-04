import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color primaryColor = Color(0xFF5985E7);
const Color secondaryColor = Color(0xFFCB6B73);
const Color backgroundColorDark = Color(0xFF1C1F24); // Color(0xFF19181F);
const Color backgroundColorLight = Color(0xFFFFFFFF);
const Color cardColorDark = Color(0xFF333942);
const Color cardColorLight = Color(0xFFF7F8FA);
const Color textColordark = Color(0XFFDADADA);
const Color shadowColorDark = Color(0xFF0A1220);
const Color shadowColorLight = Color(0xFFE8E8E8);

LinearGradient primaryGradient = const LinearGradient(
  colors: [
    primaryColor,
    secondaryColor,
  ],
  stops: [0.2, 1.0],
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
);

List<BoxShadow> get boxShadow => [
      BoxShadow(
        color: Theme.of(Get.context!)
            .shadowColor
            .withOpacity(0.35), // Shadow color
        spreadRadius: 4, // Spread radius
        blurRadius: 7, // Blur radius
        offset: const Offset(0, 0), // No offset
      ),
    ];

LinearGradient getConnectionButtonGradient(String status) {
  final MaterialColor color = getConnetionColor(status);
  if (status == 'connected') {
    return LinearGradient(
      colors: [color.shade300, color.shade400],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  } else if (connectingStatus.contains(status)) {
    return LinearGradient(
      colors: [color.shade300, color.shade400],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  } else {
    return LinearGradient(
      colors: [color.shade300, color.shade400],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }
}

MaterialColor getConnetionColor(String status) {
  if (status == 'connected') {
    return Colors.green;
  } else if (connectingStatus.contains(status)) {
    return Colors.orange;
  } else {
    return Colors.grey;
  }
}

List<String> connectingStatus = [
  "vpn_generate_config",
  "wait_connection",
  "authenticating",
  "assign_ip",
];
