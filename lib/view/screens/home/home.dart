import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:darkfire_vpn/common/navigation.dart';
import 'package:darkfire_vpn/controllers/vpn_controller.dart';
import 'package:darkfire_vpn/view/base/action_sheet.dart';
import 'package:darkfire_vpn/view/base/appBar.dart';
import 'package:darkfire_vpn/view/screens/home/widgets/connected_view.dart';
import 'package:darkfire_vpn/view/screens/split_tunnel/split_tunnel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../base/map_background.dart';
import 'widgets/disconnected_view.dart';
import '../../base/server_widget.dart';

/// Main screen of the app
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    if (Platform.isIOS) {
      AppTrackingTransparency.requestTrackingAuthorization();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        showActionSheet(
          title: 'exit_app',
          description: 'exit_app_message',
          noText: 'no'.tr,
          yesText: 'yes'.tr,
          onYes: () => exit(0),
        );
      },
      child: Scaffold(
        body: Stack(
          children: [
            const MapBackground(),
            Column(
              children: [
                CustomAppBar(
                  home: true,
                  actions: [
                    if (Platform.isAndroid)
                      IconButton(
                          onPressed: () =>
                              launchScreen(const SplitTunnelScreen()),
                          icon: Icon(
                            Iconsax.setting_4,
                            size: 20.sp,
                          )),
                  ],
                ),
                const SelectedServerWidget(),
                Expanded(
                  child: GetBuilder<VpnController>(builder: (vpnController) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: vpnController.showConnectedView
                          ? const ConnectedView()
                          : const DisconnectedView(),
                    );
                  }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
