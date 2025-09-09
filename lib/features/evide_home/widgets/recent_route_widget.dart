import 'package:evide_user/core/utils/app_imports.dart';

class RecentRouteWidget extends StatelessWidget {
  const RecentRouteWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 4.h,bottom: 4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.sp),
          border: Border.all(color: const Color.fromARGB(197, 212, 211, 211)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.routeNavigationIcon,
              width: 30.w,
              height: 30.h,
              color: const Color.fromARGB(201, 86, 1, 97),
              fit: BoxFit.contain,
            ),
            AppConstraints.kWidth8,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                recentRouteNameWidget(routeName: "Ernakulam"),
                recentRouteNameWidget(routeName: "Malappuram"),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget recentRouteNameWidget({required String routeName}) {
    return Text(
      routeName,
      style: AppCommonStyles.commonTextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12.sp,
        fontFamily: AppAssets.belanosima,
        color: Colors.black,
      ),
    );
  }
}
