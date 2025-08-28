import 'package:evide_user/Application/Cores/colors.dart';
import 'package:evide_user/Application/Widgets/animationWidgets/BusLoadingAnimation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../../../../Widgets/custom_button.dart';
import 'bloc/search_box_bloc.dart';

class SearchBoxWrapper extends StatelessWidget {
  const SearchBoxWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBoxBloc(),
      child: const SearchBoxWidget(),
    );
  }
}

class SearchBoxWidget extends StatefulWidget {
  const SearchBoxWidget({super.key});

  @override
  State<SearchBoxWidget> createState() => _SearchBoxWidgetState();
}

class _SearchBoxWidgetState extends State<SearchBoxWidget> {
  final GlobalKey fromKey = GlobalKey();
  final GlobalKey destinationKey = GlobalKey();
  final TextEditingController fromController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final FocusNode fromFocusNode = FocusNode();
  final FocusNode destinationFocusNode = FocusNode();
  String activeField = '';
  bool showSuggestions = false;

  @override
  void initState() {
    super.initState();
    fromFocusNode.addListener(_handleFocusChange);
    destinationFocusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    fromController.dispose();
    destinationController.dispose();
    fromFocusNode.dispose();
    destinationFocusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      showSuggestions = fromFocusNode.hasFocus || destinationFocusNode.hasFocus;
      activeField = fromFocusNode.hasFocus ? 'from' : 'destination';
    });
  }

  void swapFields() {
    setState(() {
      String temp = fromController.text;
      fromController.text = destinationController.text;
      destinationController.text = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBoxBloc>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocListener<SearchBoxBloc, SearchBoxState>(
      listener: (context, state) {
        if (state is SearchSuccessState) {
          print('Navigating to /searchresult with results: ${state.results}');
          Navigator.pushNamed(context, '/searchresult',
              arguments: state.results);
        }
      },
      child: BlocBuilder<SearchBoxBloc, SearchBoxState>(
        builder: (context, state) {
          if (state is SearchLoadingState) {
            fromController.clear();
            destinationController.clear();
            return const Center(child: BusLoadingAnimationWidget());
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.blue, Colors.purple],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomLeft,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  _buildTextField(
                                    controller: fromController,
                                    label: 'From',
                                    focusNode: fromFocusNode,
                                    searchBloc: searchBloc,
                                  ),
                                  const Divider(
                                      color: Colors.blue, thickness: 1.5),
                                  _buildTextField(
                                    controller: destinationController,
                                    label: 'Destination',
                                    focusNode: destinationFocusNode,
                                    searchBloc: searchBloc,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.01),
                            _buildSwapButton(),
                          ],
                        ),
                      ),
                    ),
                    Gap(screenHeight * 0.01),
                    CustomButton(
                      height: screenHeight * 0.07,
                      width: double.infinity,
                      onTap: () {
                        final from = fromController.text.trim();
                        final destination = destinationController.text.trim();

                        if (from.isNotEmpty && destination.isNotEmpty) {
                          final currentTime =
                              DateFormat('hh:mm a').format(DateTime.now());
                          searchBloc.add(PerformSearchEvent(
                            from: from,
                            destination: destination,
                            searchTime: currentTime,
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please fill out both fields.')),
                          );
                        }
                      },
                      text: 'SEARCH',
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      boxDecoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ],
                ),
                if (showSuggestions)
                  Positioned(
                    left: screenWidth * 0.01,
                    right: screenWidth * 0.01,
                    top: activeField == 'from'
                        ? screenHeight * 0.1
                        : screenHeight * 0.16,
                    child: BlocBuilder<SearchBoxBloc, SearchBoxState>(
                      builder: (context, state) {
                        if (state is SuggestionLoading) {
                          return const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [BusLoadingAnimationWidget()]);
                        } else if (state is SuggestionLoaded) {
                          final suggestions =
                              state.suggestions.toSet().toList();

                          if (suggestions.isEmpty) {
                            return const SizedBox.shrink();
                          }

                          return Container(
                            constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.18,
                            ),
                            decoration: BoxDecoration(
                              color: backGroundColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: suggestions.length,
                              itemBuilder: (context, index) {
                                final suggestion = suggestions[index];
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (activeField == 'from') {
                                        fromController.text = suggestion;
                                      } else if (activeField == 'destination') {
                                        destinationController.text = suggestion;
                                      }
                                      searchBloc.add(SearchClear());
                                      showSuggestions = false;
                                    });
                                  },
                                  child: Container(
                                    height: screenHeight * 0.06,
                                    color: Colors.transparent,
                                    child: Text(
                                      suggestion,
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: screenWidth * 0.047,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else if (state is SuggestionError) {
                          return Center(child: Text(state.message));
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required FocusNode focusNode,
    required SearchBoxBloc searchBloc,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: label,
        hintText: 'Where to?',
        border: InputBorder.none,
      ),
      onChanged: (value) {
        searchBloc.add(SearchSuggestionsEvent(query: value.trim()));
      },
    );
  }

  Widget _buildSwapButton() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.15,
      height: screenHeight * 0.053,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomLeft,
        ),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          height: screenHeight * 0.049,
          width: screenWidth * 0.13,
          decoration:
              BoxDecoration(color: backGroundColor, shape: BoxShape.circle),
          child: InkWell(
            onTap: swapFields,
            child: const Icon(Icons.swap_vert, size: 25, color: textColor),
          ),
        ),
      ),
    );
  }
}
