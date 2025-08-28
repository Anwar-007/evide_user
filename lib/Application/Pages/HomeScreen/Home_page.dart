import 'package:evide_user/Application/Cores/colors.dart';
import 'package:evide_user/Application/Pages/HomeScreen/User_Home_bloc/user_home_bloc.dart';
import 'package:evide_user/Application/Pages/HomeScreen/widget/Search_box/bloc/search_box_bloc.dart';
import 'package:evide_user/Application/Pages/HomeScreen/widget/topnavigation_button.dart';
import 'package:evide_user/Application/Widgets/taxi/votefortaxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'widget/Card_buttons/card_buttons_widget.dart';
import 'widget/Search_box/search_box_widget.dart';
import 'widget/Travel_prompt_box/Prompt_travelBox.dart';
import 'widget/news_tile/news_tile_widget.dart';

class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SearchBoxBloc()),
        BlocProvider(
            create: (context) =>
                UserHomeBloc()), // Ensure UserHomeBloc is provided here
      ],
      child: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  late UserHomeBloc homeBloc;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeBloc = context.read<UserHomeBloc>(); // Safely access the bloc here
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocListener<UserHomeBloc, UserHomeState>(
      listener: (context, state) {
        if (state is UserHomeVoteSuccessState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showThankYouDialog(context, state.message);
          });
        } else if (state is UserHomeErrorState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showErrorDialog(context, state.error);
          });
        }
      },
      child: Scaffold(
        backgroundColor: backGroundColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TopnavigationButton(
                      image: Image.asset(
                        'asset/images/a.png',
                        height: screenHeight * 0.08,
                        width: screenWidth * 0.3,
                      ),
                      onTap: () {},
                    ),
                    Gap(screenWidth * 0.03),
                    // TopnavigationButton(
                    //   image: Image.asset(
                    //     'asset/images/b.png',
                    //     height: screenHeight * 0.08,
                    //     width: screenWidth * 0.3,
                    //   ),
                    //   onTap: () => showVotingDialog(
                    //       context,
                    //       'Train',
                    //       _nameController,
                    //       _emailController,
                    //       (context, vote) => homeBloc.add(SaveVoteEvent(
                    //             collectionName: 'Train',
                    //             name: _nameController.text,
                    //             email: _emailController.text,
                    //             vote: vote,
                    //           ))),
                    // ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Builder(
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.02,
                            horizontal: screenWidth * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SearchBoxWrapper(),
                            // Gap(screenHeight * 0.02),
                            // const CardButonWrapper(),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.05),
                              child: Text(
                                "Let's get news updates",
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            NewsTileWidget(),
                            Gap(screenHeight * 0.02),
                            // const PromptTravel(),
                            Gap(screenHeight * 0.02),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
