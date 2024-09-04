import 'package:cached_network_image/cached_network_image.dart';
import 'package:darkfire_vpn/common/loading.dart';
import 'package:darkfire_vpn/controllers/servers_controller.dart';
import 'package:darkfire_vpn/controllers/vpn_controller.dart';
import 'package:darkfire_vpn/data/model/body/vpn_config.dart';
import 'package:darkfire_vpn/utils/colors.dart';
import 'package:darkfire_vpn/utils/style.dart';
import 'package:darkfire_vpn/view/base/signal_widget.dart';
import 'package:darkfire_vpn/view/base/appBar.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/images.dart';

class ServerScreen extends StatefulWidget {
  const ServerScreen({super.key});

  @override
  State<ServerScreen> createState() => _ServerScreenState();
}

class _ServerScreenState extends State<ServerScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ServerController.find.getAllServers();
    });
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
              const CustomAppBar(text: 'Servers'),
              Expanded(
                child: GetBuilder<ServerController>(
                  builder: (serverController) {
                    return serverController.loading
                        ? const Loading()
                        : RefreshIndicator(
                            onRefresh: () async {
                              await serverController.getAllServers();
                            },
                            child: ListView.separated(
                              padding: pagePadding,
                              itemCount: serverController.allServers.length,
                              separatorBuilder: (context, index) => Divider(
                                  color: Theme.of(context).dividerColor),
                              itemBuilder: (context, index) {
                                var server = serverController.allServers[index];
                                return InkWell(
                                    onTap: () => VpnController.find
                                        .selectServer(context, server),
                                    child: ServerItem(server: server));
                              },
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ServerItem extends StatefulWidget {
  final VpnConfig? server;
  const ServerItem({required this.server, super.key});

  @override
  State<ServerItem> createState() => _ServerItemState();
}

class _ServerItemState extends State<ServerItem>
    with AutomaticKeepAliveClientMixin {
  int ms = 0;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    super.build(context);

    return Row(
      children: [
        if (widget.server != null)
          // Country Flag
          CircleAvatar(
            radius: 18.sp,
            backgroundColor: primaryColor,
            backgroundImage: widget.server!.flag.contains("http")
                ? CachedNetworkImageProvider(widget.server!.flag)
                : null,
            child: widget.server!.flag.contains("http")
                ? null
                : ClipRRect(
                    borderRadius: BorderRadius.circular(32.sp),
                    child: Image.asset(
                      "icons/flags/png/${widget.server!.flag}.png",
                      package: "country_icons",
                      width: 18.sp,
                      height: 18.sp,
                    ),
                  ),
          ),
        SizedBox(width: 16.sp),
        // Country Name and Location
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.server?.name ?? 'Select Server'.tr,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 3.sp),
              FutureBuilder(
                future: Future.microtask(() =>
                    Ping(widget.server?.serverIp ?? '', count: 1).stream.first),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.waiting) {
                    ms = DateTime.now().difference(now).inMilliseconds;
                  }
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$ms ms  ●  ',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SignalBar(signalStrength: ms),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const Spacer(),

        Icon(Icons.arrow_forward_ios, size: 18.sp),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
