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
            mainAxisAlignment: MainAxisAlignment.start,
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
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenHeight * 0.015),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Plan your ride',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.06,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(screenHeight * 0.005),
                            Text(
                              'Search routes and get live updates',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: screenWidth * 0.035,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Icon(Icons.directions_bus,
                          color: Colors.white, size: screenWidth * 0.12),
                    ],
                  ),
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
                            Gap(screenHeight * 0.02),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.05),
                              child: GradientText(
                                'Quick actions',
                                gradient: const LinearGradient(
                                  colors: [Colors.blue, Colors.purple],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                fontSize: screenWidth * 0.05,
                              ),
                            ),
                            Gap(screenHeight * 0.01),
                            const CardButonWrapper(),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.05),
                              child: GradientText(
                                'Latest news',
                                gradient: const LinearGradient(
                                  colors: [Colors.blue, Colors.purple],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                fontSize: screenWidth * 0.05,
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
