import 'package:darkfire_vpn/controllers/localization_controller.dart';
import 'package:darkfire_vpn/utils/app_constants.dart';
import 'package:darkfire_vpn/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/colors.dart';
import '../../../utils/style.dart';

class LanguageSheet extends StatelessWidget {
  const LanguageSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: pagePadding,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.sp),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'select_language'.tr,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 24.sp),
          Expanded(
            child: GetBuilder<LocalizationController>(builder: (con) {
              return ListView.separated(
                itemCount: AppConstants.languages.length,
                separatorBuilder: (context, index) => SizedBox(height: 10.sp),
                itemBuilder: (context, index) {
                  bool selected = con.selectedIndex == index;
                  final language = AppConstants.languages[index];
                  return InkWell(
                    onTap: () {
                      final con = LocalizationController.to;
                      con.setSelectIndex(index);
                      LocalizationController.to.setLanguage(
                        Locale(language.languageCode, language.countryCode),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        color: selected
                            ? Theme.of(context).primaryColor.withOpacity(0.1)
                            : null,
                        border: Border.all(
                          color: selected
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            "${Images.flag}${language.countryCode.toLowerCase()}.png",
                            width: 24.sp,
                            height: 24.sp,
                          ),
                          SizedBox(width: 10.sp),
                          Expanded(
                            child: Text(
                              language.languageName,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          SizedBox(width: 10.sp),
                          if (selected)
                            Icon(
                              Icons.check,
                              color: primaryColor,
                              size: 20.sp,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
