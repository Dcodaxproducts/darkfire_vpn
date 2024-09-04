import 'package:darkfire_vpn/common/navigation.dart';
import 'package:darkfire_vpn/controllers/vpn_controller.dart';
import 'package:darkfire_vpn/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common/primary_button.dart';
import '../../connection_report/report.dart';

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
    return Container(
      height: 185.sp,
      width: double.infinity,
      padding: pagePadding,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.sp),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Disconnect VPN?",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.sp),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.sp),
            child: Text(
              "Are you sure you want to end the VPN connection?",
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 32.sp),
          // buttons,
          Row(
            children: [
              const Expanded(
                child: PrimaryOutlineButton(
                  text: 'No',
                  onPressed: pop,
                ),
              ),
              SizedBox(width: 10.sp),
              Expanded(
                child: PrimaryButton(
                  text: 'Yes',
                  onPressed: () {
                    VpnController.find.disconnect((vpnStats, vpnConfig) {
                      pop();
                      launchScreen(
                        ReportScreen(
                          vpnStatus: vpnStats,
                          vpnConfig: vpnConfig,
                        ),
                      );
                    });
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
