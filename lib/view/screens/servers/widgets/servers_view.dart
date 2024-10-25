import 'package:cached_network_image/cached_network_image.dart';
import 'package:darkfire_vpn/common/navigation.dart';
import 'package:darkfire_vpn/controllers/localization_controller.dart';
import 'package:darkfire_vpn/controllers/subscription_controller.dart';
import 'package:darkfire_vpn/controllers/vpn_controller.dart';
import 'package:darkfire_vpn/data/model/body/vpn_config.dart';
import 'package:darkfire_vpn/helper/vpn_helper.dart';
import 'package:darkfire_vpn/utils/colors.dart';
import 'package:darkfire_vpn/utils/style.dart';
import 'package:darkfire_vpn/view/base/action_sheet.dart';
import 'package:darkfire_vpn/view/base/signal_widget.dart';
import 'package:darkfire_vpn/view/screens/subscription/subscription.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:iconsax/iconsax.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';
import '../../../../controllers/ads_controller.dart';

class ServersView extends StatelessWidget {
  final List<VpnConfig> servers;
  final bool pro;
  const ServersView({required this.servers, this.pro = false, super.key});

  @override
  Widget build(BuildContext context) {
    return servers.isNotEmpty
        ? ListView.separated(
            padding: pagePadding,
            itemCount: servers.length,
            separatorBuilder: (context, index) => const SizedBox(height: 24),
            itemBuilder: (context, index) {
              var server = servers[index];
              return InkWell(
                onTap: () {
                  bool isProSever = server.status == 1;
                  if (isProSever && !isPro) {
                    launchScreen(const SubscriptionScreen());
                    return;
                  }
                  if (VpnController.find.isConnected) {
                    Get.bottomSheet(ActionSheet(
                      title: 'change_server',
                      description: 'change_server_message',
                      noText: 'no',
                      yesText: "change",
                      onYes: () {
                        pop();
                        VpnController.find.disconnect((status, config) {
                          Future.delayed(const Duration(milliseconds: 500), () {
                            VpnController.find.selectServer(
                              server,
                              callback: _connectButtonClick,
                            );
                          });
                        });
                      },
                    ));
                  } else {
                    VpnController.find.selectServer(server);
                  }
                },
                // dont show any affect of inkwell
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: GetBuilder<VpnController>(builder: (vpnController) {
                  bool selected = vpnController.vpnConfig?.name == server.name;
                  return ServerItem(server: server, selected: selected);
                }),
              );
            },
          )
        : Center(child: Text('no_servers_available'.tr));
  }

  void _connectButtonClick() {
    var vpnProvider = VpnController.find;
    if (vpnProvider.vpnStage?.toLowerCase() !=
        VPNStage.disconnected.name.toLowerCase()) {
      vpnProvider.disconnect((vpnStatus, vpnConfig) {});
      if (vpnProvider.isConnected) {
        _showInterstitialAd();
      }
    } else {
      vpnProvider.connect();
      _showInterstitialAd();
    }
  }

  Future<void> _showInterstitialAd() async {
    final AdsController adsController = AdsController.find;
    final String interstitialAdId = adsController.interstitialAdId;
    bool isAdAvailable = adsController.isAdIdActive(interstitialAdId);
    if (!isAdAvailable) {
      return;
    }
    InterstitialAd? interstitialAd =
        await adsController.loadInterstitial(interstitialAdId);
    if (interstitialAd != null) {
      await interstitialAd.showIfNotPro();
    }
  }
}

class ServerItem extends StatefulWidget {
  final VpnConfig? server;
  final bool selected;
  const ServerItem({required this.server, required this.selected, super.key});

  @override
  State<ServerItem> createState() => _ServerItemState();
}

class _ServerItemState extends State<ServerItem>
    with AutomaticKeepAliveClientMixin {
  int ms = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.sp),
        border: Border.all(
          color:
              widget.selected ? primaryColor : Theme.of(context).dividerColor,
          width: 0.75,
        ),
      ),
      child: Row(
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
                  widget.server?.name ?? 'select_server'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 3.sp),
                FutureBuilder(
                  future: Future.microtask(() =>
                      Ping(widget.server?.serverIp ?? '', count: 1)
                          .stream
                          .first),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.waiting) {
                      var pingData = snapshot.data;
                      ms = pingData?.response?.time?.inMilliseconds ?? 999;
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

          GetBuilder<LocalizationController>(builder: (con) {
            IconData ltrIcon = Iconsax.arrow_right_3;
            IconData rtlIcon = Iconsax.arrow_left_2;
            return Icon(con.isLtr ? ltrIcon : rtlIcon, size: 18.sp);
          }),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
