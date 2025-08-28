import 'package:evide_user/Application/Cores/colors.dart';
import 'package:evide_user/Application/Pages/searchResultScreen/search_result_bloc/search_result_bloc.dart';
import 'package:evide_user/Application/Pages/searchResultScreen/widget/busList_widget.dart';
import 'package:evide_user/Application/Pages/searchResultScreen/widget/errorbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchresultWrapper extends StatelessWidget {
  const SearchresultWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SearchResultBloc(),
        child: const SearchedBuslist());
  }
}

class SearchedBuslist extends StatefulWidget {
  const SearchedBuslist({super.key});

  @override
  State<SearchedBuslist> createState() => _SearchedBuslistState();
}

class _SearchedBuslistState extends State<SearchedBuslist> {
  List<Map<String, dynamic>>? _searchResult;
  Map<String, dynamic>? _selectedItem;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments
        as List<Map<String, dynamic>>?;
    if (args != null) {
      _searchResult = args.reversed.toList();
    }
  }

  @override
  void initState() {
    _searchResult = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backGroundColor,
      ),
      backgroundColor: backGroundColor,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(screenHeight * 0.03),
          child: Column(
            children: [
              if (_searchResult != null && _searchResult!.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: _searchResult!.length + 1,
                    itemBuilder: (context, index) {
                      // Show the container at the end of the list
                      if (index == _searchResult!.length) {
                        return _buildBottomContainer();
                      }

                      return ListItem(
                        item: _searchResult![index],
                        onTap: () {
                          setState(() {
                            _selectedItem = _searchResult![index];
                          });
                          Navigator.pushNamed(context, '/showtimeline',
                              arguments: _selectedItem);
                        },
                      );
                    },
                  ),
                ),
              if (_searchResult == null || _searchResult!.isEmpty)
                Expanded(child: _buildBottomContainer())
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomContainer() {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: screenHeight * 0.3,
      margin:  EdgeInsets.only(top: screenHeight * 0.02),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ErrorBoxWrapper()
    );
  }
}
