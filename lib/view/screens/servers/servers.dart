import 'package:darkfire_vpn/controllers/servers_controller.dart';
import 'package:darkfire_vpn/utils/style.dart';
import 'package:darkfire_vpn/view/base/appBar.dart';
import 'package:darkfire_vpn/view/screens/servers/widgets/servers_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../base/map_background.dart';
import '../../base/tabButton.dart';

class ServerScreen extends StatefulWidget {
  const ServerScreen({super.key});

  @override
  State<ServerScreen> createState() => _ServerScreenState();
}

class _ServerScreenState extends State<ServerScreen> {
  final _pageController = PageController();
  ServerController serverController = ServerController.find;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getServers();
    });
    super.initState();
  }

  void _changePage(int index) {
    _getServers();
    if (_pageController.hasClients) {
      _pageController.jumpToPage(index);
    }

    ServerController.find.currentIndex = index;
  }

  _getServers() {
    if (serverController.allServers.isEmpty) {
      serverController.getAllServers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MapBackground(),
          GetBuilder<ServerController>(builder: (serverController) {
            var freeSevers = serverController.allServers
                .where((e) => e.status == 0)
                .toList();
            var proServers = serverController.allServers
                .where((e) => e.status == 1)
                .toList();
            return Column(
              children: [
                CustomAppBar(text: 'servers'.tr),
                SizedBox(height: defaultSpacing),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: defaultSpacing),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(32.sp),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: AnimatedTabButton(
                          selected: serverController.currentIndex == 0,
                          text: 'free_servers'.tr,
                          onTap: () => _changePage(0),
                        ),
                      ),
                      Expanded(
                        child: AnimatedTabButton(
                          selected: serverController.currentIndex == 1,
                          text: 'pro_servers'.tr,
                          onTap: () => _changePage(1),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.sp),
                Expanded(
                    child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    RefreshIndicator(
                      onRefresh: () async {
                        await serverController.getAllServers();
                      },
                      child: ServersView(servers: freeSevers),
                    ),
                    RefreshIndicator(
                      onRefresh: () async {
                        await serverController.getAllServers();
                      },
                      child: ServersView(servers: proServers),
                    ),
                  ],
                )),
              ],
            );
          }),
        ],
      ),
    );
  }
}
