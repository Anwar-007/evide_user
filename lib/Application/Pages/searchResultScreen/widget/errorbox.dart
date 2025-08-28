
import 'package:evide_user/Application/Cores/colors.dart';
import 'package:evide_user/Application/Pages/searchResultScreen/search_result_bloc/search_result_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ErrorBoxWrapper extends StatelessWidget {
  const ErrorBoxWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchResultBloc(),
      child: Errorbox(),
    );
  }
}

class Errorbox extends StatefulWidget {
  const Errorbox({super.key});

  @override
  State<Errorbox> createState() => _ErrorboxState();
}

class _ErrorboxState extends State<Errorbox> {
  @override
  void initState() {
    BlocProvider.of<SearchResultBloc>(context).add(FetchLiveLocation());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<SearchResultBloc, SearchResultState>(
      builder: (context, state) {
        if (state is PhonenumberLoaded) {
          return Padding(
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: Center(
              child: Column(
                children: [
                  Text(
                    "ബസ് ഉടമകൾ ഇതിൽ ആഡ് ചെയ്യാത്തത് കൊണ്ട് ആണ് ബസ് കാണിക്കാത്തത് ദയവായി അവരോട് ബസ് ആഡ് ചെയ്യാൻ പറയു...\n Or",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.03,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gap(screenHeight * 0.02),
                  Text(
                    "ബസ് ന്റെ തത്സമയം അറിയാൻ വിളിക്കു....${state.phoneNumber}",
                    style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.04),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
