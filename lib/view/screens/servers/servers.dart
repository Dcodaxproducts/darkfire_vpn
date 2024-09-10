import 'package:darkfire_vpn/controllers/servers_controller.dart';
import 'package:darkfire_vpn/utils/style.dart';
import 'package:darkfire_vpn/view/base/appBar.dart';
import 'package:darkfire_vpn/view/screens/servers/widgets/servers_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/colors.dart';
import '../../base/map_background.dart';

class ServerScreen extends StatefulWidget {
  const ServerScreen({super.key});

  @override
  State<ServerScreen> createState() => _ServerScreenState();
}

class _ServerScreenState extends State<ServerScreen>
    with TickerProviderStateMixin {
  ServerController serverCon = ServerController.find;
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getServers();
    });
    super.initState();
  }

  _getServers() {
    if (serverCon.allServers.isEmpty) {
      serverCon.getAllServers();
    }
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
              ServerTabBar(tabController: _tabController),
              SizedBox(height: 24.sp),
              GetBuilder<ServerController>(builder: (serverController) {
                var freeSevers = serverController.allServers
                    .where((e) => e.status == 0)
                    .toList();
                var proServers = serverController.allServers
                    .where((e) => e.status == 1)
                    .toList();
                return Expanded(
                    child: TabBarView(
                  controller: _tabController,
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
                ));
              }),
            ],
          ),
        ],
      ),
    );
  }
}

class ServerTabBar extends StatelessWidget {
  const ServerTabBar({
    super.key,
    required TabController? tabController,
  }) : _tabController = tabController;

  final TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.sp),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(32.sp),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: TabBar(
        controller: _tabController,
        padding: EdgeInsets.zero,
        indicatorPadding: EdgeInsets.zero,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(32.sp),
          color: primaryColor,
        ),
        indicatorWeight: 0,
        splashBorderRadius: BorderRadius.circular(32.sp),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelStyle: Theme.of(context).textTheme.bodySmall,
        unselectedLabelColor: Theme.of(context).textTheme.bodyMedium?.color,
        labelColor: Colors.white,
        tabs: [
          Tab(
            text: 'free_servers'.tr,
          ),
          Tab(
            text: 'pro_servers'.tr,
          ),
        ],
      ),
    );
  }
}
