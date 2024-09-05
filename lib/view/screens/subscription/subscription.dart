import 'package:darkfire_vpn/common/primary_button.dart';
import 'package:darkfire_vpn/data/model/body/subscription_model.dart';
import 'package:darkfire_vpn/utils/app_constants.dart';
import 'package:darkfire_vpn/utils/style.dart';
import 'package:darkfire_vpn/view/base/appBar.dart';
import 'package:darkfire_vpn/view/base/map_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../controllers/iap_controller.dart';
import '../../../utils/colors.dart';
import 'widgets/purchase_item.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int _selectedIndex = 0;
  List<String> get benefits => [
        'No Ads',
        'Unlimited Time',
        'Access to all servers',
        'Ultra-fast connection',
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MapBackground(),
          const CustomAppBar(text: '', premium: true),
          Padding(
            padding: pagePadding,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 50.sp),
                      GetBuilder<IAPController>(
                        builder: (value) => LottieBuilder.asset(
                          "assets/animations/crown_pro.json",
                          width: 150.sp,
                        ),
                      ),
                      Text(
                        'Upgrade to DarkFire Pro',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),

                      // benefits,
                      GridView.builder(
                        padding: EdgeInsets.only(top: 32.sp),
                        shrinkWrap: true,
                        itemCount: benefits.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 10,
                        ),
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: primaryColor,
                                size: 16.sp,
                              ),
                              SizedBox(width: 4.sp),
                              Text(
                                benefits[index],
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          );
                        },
                      ),
                      // subscription list
                      ListView.separated(
                        padding: EdgeInsets.only(top: 32.sp),
                        itemCount: AppConstants.subscriptionList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: defaultSpacing),
                        itemBuilder: (context, index) {
                          final SubscriptionModel item =
                              AppConstants.subscriptionList[index];
                          return PurchaseItem(
                            item: item,
                            selected: _selectedIndex == index,
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                          );
                        },
                      ),

                      //
                      Padding(
                        padding: EdgeInsets.only(top: 32.sp),
                        child: RichText(
                          text: TextSpan(
                            text:
                                'This subscription is auto-renewable, will be re- activated at the end of selected period and can be cancelled at any time. ',
                            style: Theme.of(context).textTheme.bodySmall,
                            children: const [
                              TextSpan(
                                text: ' Cancel Subscription',
                                style: TextStyle(
                                  color: primaryColor,
                                  decoration: TextDecoration.underline,
                                  decorationColor: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    text: 'Continue',
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 16.sp),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.sp),
                  child: RichText(
                    text: TextSpan(
                      text: 'By continuing, you agree to our ',
                      style: Theme.of(context).textTheme.bodySmall,
                      children: const [
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            color: primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: primaryColor,
                          ),
                        ),
                        TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Google Terms of Service',
                          style: TextStyle(
                            color: primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: primaryColor,
                          ),
                        ),
                        TextSpan(
                            text: ' which describes how the data is handled.'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
