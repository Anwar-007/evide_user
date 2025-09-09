import 'package:evide_user/core/components/space_between_widget_show_listtile.dart';
import 'package:evide_user/core/utils/app_imports.dart';
import 'package:evide_user/features/evide_home/widgets/home_page_search_bar.dart';
import 'package:evide_user/features/evide_home/widgets/recent_route_widget.dart';
import 'package:flutter_svg/svg.dart';

class EvideHomePage extends StatefulWidget {
  EvideHomePage({super.key});

  @override
  State<EvideHomePage> createState() => _EvideHomePageState();
}

class _EvideHomePageState extends State<EvideHomePage> {
  TextEditingController searchController = TextEditingController();

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.only(left: 10.w),
          width: 50.w,
          height: 50.h,
          child: Image.asset(
            AppAssets.pngApplogo,
            fit: BoxFit.contain,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'EVIDE',
              style: AppCommonStyles.commonTextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  borderRadius: BorderRadius.circular(30.sp),
                  color: Colors.amber,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      AppAssets.locationIcon,
                      height: isExpanded ? 15 : 20,
                    ),
                    if (isExpanded)
                      Text(
                        "Kerala, India",
                        style: AppCommonStyles.commonTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppAssets.belanosima,
                        ),
                      )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          HomePageSearchBar(searchController: searchController),
          // showing 3 routes user recent searched
          AppConstraints.kHeight10,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                10,
                (index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: RecentRouteWidget(),
                  );
                },
              ),
            ),
          ),
          // nearby stops navigate part
          SpaceBetweenWidgetShowListTIle(
            leadingtext: "Nearby Stops",
            trialingText: "See all stops",
            trailingTextStyle: AppCommonStyles.commonTextStyle(fontSize: 11.sp),
          ),
          //
          SpaceBetweenWidgetShowListTIle(
            leadingtext: "Find our services",
            trialingText: "View all",
            trailingTextStyle: AppCommonStyles.commonTextStyle(fontSize: 11.sp),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                10,
                (index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    height: 150.h,
                    width: 280.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.sp),
                      color: Colors.lightGreenAccent,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
