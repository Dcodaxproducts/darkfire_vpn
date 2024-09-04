import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:darkfire_vpn/controllers/vpn_controller.dart';
import 'package:darkfire_vpn/utils/images.dart';
import 'package:darkfire_vpn/view/base/appBar.dart';
import 'package:darkfire_vpn/view/screens/home/widgets/connected_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';
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
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            Images.map,
            fit: BoxFit.cover,
            color: Theme.of(context).hintColor.withOpacity(0.5),
          ),
          Column(
            children: [
              const CustomAppBar(home: true),
              const SelectedServerWidget(),
              Expanded(
                child: GetBuilder<VpnController>(builder: (vpnController) {
                  String status =
                      vpnController.vpnStage ?? VPNStage.disconnected.name;
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: status == 'connected'
                        ? const ConnectedView()
                        : const DisconnectedView(),
                  );
                }),
              ),
            ],
          )
        ],
      ),
    );
  }
}
