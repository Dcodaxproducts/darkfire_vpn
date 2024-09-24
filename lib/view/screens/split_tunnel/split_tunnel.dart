import 'package:darkfire_vpn/common/loading.dart';
import 'package:darkfire_vpn/controllers/tunnel_controller.dart';
import 'package:darkfire_vpn/view/base/appBar.dart';
import 'package:darkfire_vpn/view/base/divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/colors.dart';
import '../../base/map_background.dart';

class SplitTunnelScreen extends StatefulWidget {
  const SplitTunnelScreen({super.key});

  @override
  State<SplitTunnelScreen> createState() => _SplitTunnelScreenState();
}

class _SplitTunnelScreenState extends State<SplitTunnelScreen> {
  @override
  void initState() {
    SplitTunnelController.find.getInstalledApps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MapBackground(),
          Column(
            children: [
              CustomAppBar(text: 'split_tunnel'.tr),
              // note:
              Text(
                'split_tunneling_allows_you_to_choose_which_apps_use_the_vpn_and_which_apps_do_not_you_need_to_reconnect_vpn_to_see_changes'
                    .tr,
                style: Theme.of(context).textTheme.bodyMedium,
              ).paddingAll(16.sp),
              Expanded(
                child: GetBuilder<SplitTunnelController>(
                  builder: (con) {
                    return con.loading
                        ? const Loading()
                        : ListView.separated(
                            padding: EdgeInsets.zero,
                            itemCount: con.apps.length,
                            separatorBuilder: (context, index) =>
                                const CustomDivider(),
                            itemBuilder: (context, index) {
                              bool selected = con.excludedApps
                                  .contains(con.apps[index].packageName);
                              selected = !selected;
                              return CheckboxListTile(
                                title: Text(
                                  con.apps[index].name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                secondary: con.apps[index].icon != null
                                    ? Image.memory(
                                        con.apps[index].icon!,
                                        width: 40.sp,
                                        height: 40.sp,
                                      )
                                    : const SizedBox(),
                                value: selected,
                                onChanged: (value) {
                                  con.toggleApp(con.apps[index].packageName);
                                },
                                side: BorderSide(
                                    color: Theme.of(context).shadowColor),
                                checkboxShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.sp),
                                ),
                                fillColor: WidgetStateProperty.all(
                                  selected
                                      ? primaryColor
                                      : Theme.of(context).shadowColor,
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16.sp),
                              );
                            },
                          );
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
