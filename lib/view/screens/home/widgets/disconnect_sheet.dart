import 'package:darkfire_vpn/common/navigation.dart';
import 'package:darkfire_vpn/controllers/vpn_controller.dart';
import 'package:darkfire_vpn/view/base/action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../report/report.dart';

showDisconnectSheet() {
  showModalBottomSheet(
    context: Get.context!,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20.sp),
      ),
    ),
    builder: (context) => const DisconnectSheet(),
  );
}

class DisconnectSheet extends StatelessWidget {
  const DisconnectSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ActionSheet(
      title: "disconnect_vpn?",
      description: "disconnect_vpn_message",
      noText: 'no',
      yesText: 'yes',
      onYes: () {
        VpnController.find.disconnect((vpnStats, vpnConfig) {
          pop();
          Future.delayed(const Duration(milliseconds: 300), () {
            launchScreen(
              ReportScreen(
                vpnStatus: vpnStats,
                vpnConfig: vpnConfig,
              ),
            );
          });
        });
      },
    );
  }
}
