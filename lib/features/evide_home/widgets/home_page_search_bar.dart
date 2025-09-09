import 'package:evide_user/core/components/common_text_form_field_widget.dart';
import 'package:evide_user/core/utils/app_imports.dart';

class HomePageSearchBar extends StatelessWidget {
  const HomePageSearchBar({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      width: ScreenUtil().screenWidth,
      height: 46.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.sp),
        color: const Color.fromARGB(158, 210, 208, 208),
      ),
      child: Row(
        children: [
          Expanded(
            child: CommonTextFormFieldWidget(
              onTap: () {
                // Navigation method to route search page
              },
              readOnly: true,
              showCursor: false,
              controller: searchController,
              hintText: "Search your destination...",
              border: InputBorder.none,
            ),
          ),
          VerticalDivider(
            thickness: 1,
            endIndent: 6,
            indent: 6,
            color: const Color.fromARGB(255, 193, 193, 193),
          ),
          AppConstraints.kHeight5,
          Image.asset(
            AppAssets.searchIcon,
            width: 20.w,
            height: 20.h,
            color: Colors.purple,
          ),
        ],
      ),
    );
  }
}
