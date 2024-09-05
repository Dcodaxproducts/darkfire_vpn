import 'package:darkfire_vpn/common/loading.dart';
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
  int _currentIndex = 0;
  final _pageController = PageController();
  ServerController serverController = ServerController.find;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (serverController.freeServers.isEmpty) {
        serverController.getAllFreeServers();
      }
    });
    super.initState();
  }

  void _changePage(int index) {
    if (_pageController.hasClients) {
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
    if (index == 0) {
      if (serverController.freeServers.isEmpty) {
        serverController.getAllFreeServers();
      }
    } else {
      if (serverController.proServers.isEmpty) {
        serverController.getAllProServers();
      }
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MapBackground(),
          Column(
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
                        selected: _currentIndex == 0,
                        text: 'free_servers'.tr,
                        onTap: () => _changePage(0),
                      ),
                    ),
                    Expanded(
                      child: AnimatedTabButton(
                        selected: _currentIndex == 1,
                        text: 'pro_servers'.tr,
                        onTap: () => _changePage(1),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.sp),
              GetBuilder<ServerController>(builder: (serverController) {
                return Expanded(
                    child: serverController.loading
                        ? const Loading()
                        : PageView(
                            controller: _pageController,
                            onPageChanged: _changePage,
                            children: [
                              RefreshIndicator(
                                onRefresh: () async {
                                  await serverController.getAllFreeServers();
                                },
                                child: ServersView(
                                    servers: serverController.freeServers),
                              ),
                              RefreshIndicator(
                                onRefresh: () async {
                                  await serverController.getAllProServers();
                                },
                                child: ServersView(
                                    servers: serverController.proServers),
                              ),
                            ],
                          ));
              }),
            ],
          ),
        ],
      ),
    );
  }
}
