import 'dart:io';

extension SpeedTest on double {
  double get divideByTwo => Platform.isIOS ? this / (1.8) : this;
}
