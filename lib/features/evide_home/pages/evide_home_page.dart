import 'package:evide_user/core/components/common_text_form_field_widget.dart';
import 'package:evide_user/core/utils/app_imports.dart';
import 'package:evide_user/features/evide_home/widgets/home_page_search_bar.dart';
import 'package:gap/gap.dart';

class EvideHomePage extends StatelessWidget {
  EvideHomePage({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: false,
              expandedHeight: 50.h,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Evide AI',
                  style: AppCommonStyles.commonTextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                centerTitle: true,
              ),
            ),
            SliverToBoxAdapter(child: Gap(20.h),),
            SliverToBoxAdapter(
              child: HomePageSearchBar(searchController: searchController),
            ),
          ];
        },
        body: Container(),
      ),
    );
  }
}
