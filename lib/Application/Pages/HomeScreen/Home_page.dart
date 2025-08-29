import 'package:evide_user/Application/Cores/colors.dart';
import 'package:evide_user/Application/Pages/HomeScreen/User_Home_bloc/user_home_bloc.dart';
import 'package:evide_user/Application/Pages/HomeScreen/widget/Search_box/bloc/search_box_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'widget/Search_box/search_box_widget.dart';

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
  bool _locationEnabled = false;
  String? _serviceAlert = 'Service disruption on Route 10 near Central';
  DateTime _lastUpdated = DateTime.now();
  int _selectedIndex = 0;

  List<NearbyStop> _nearbyStops = [
    NearbyStop(
      name: 'Main St & 3rd',
      distanceMeters: 180,
      arrivals: [
        Arrival(route: '10', eta: '3 min'),
        Arrival(route: '22', eta: '7 min'),
      ],
    ),
    NearbyStop(
      name: 'Central Station',
      distanceMeters: 420,
      arrivals: [
        Arrival(route: '5', eta: 'Due'),
        Arrival(route: '10', eta: '5 min'),
      ],
    ),
    NearbyStop(
      name: 'Park Ave',
      distanceMeters: 610,
      arrivals: [
        Arrival(route: '7B', eta: '12 min'),
      ],
    ),
  ];

  void _refreshData() {
    setState(() {
      _lastUpdated = DateTime.now();
    });
  }

  void _toggleLocation() {
    setState(() {
      _locationEnabled = !_locationEnabled;
    });
  }
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
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.012),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bus Tracker',
                            style: TextStyle(
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                _locationEnabled ? Icons.location_on : Icons.location_off,
                                size: screenWidth * 0.045,
                                color: _locationEnabled ? Colors.green : Colors.red,
                              ),
                              Gap(screenWidth * 0.01),
                              Text(
                                _locationEnabled ? 'Location enabled' : 'Location off',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _toggleLocation,
                      icon: const Icon(Icons.my_location),
                      label: const Text('Use my location'),
                    ),
                  ],
                ),
              ),
              if (_serviceAlert != null)
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.006),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8E1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFFFECB3)),
                    ),
                    padding: EdgeInsets.all(screenWidth * 0.03),
                    child: Row(
                      children: [
                        const Icon(Icons.warning_amber_rounded, color: Colors.amber),
                        Gap(screenWidth * 0.02),
                        Expanded(
                          child: Text(
                            _serviceAlert!,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: screenWidth * 0.035,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() => _serviceAlert = null);
                          },
                          child: const Text('Dismiss'),
                        )
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
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton.icon(
                                onPressed: _toggleLocation,
                                icon: const Icon(Icons.my_location),
                                label: const Text('Use my location'),
                              ),
                            ),
                            Gap(screenHeight * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Nearby stops',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.05,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: _refreshData,
                                      icon: const Icon(Icons.refresh),
                                      tooltip: 'Refresh',
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Text(
                              'Last updated: '
                              '${_lastUpdated.hour.toString().padLeft(2, '0')}:${_lastUpdated.minute.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: screenWidth * 0.032,
                              ),
                            ),
                            Gap(screenHeight * 0.008),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _nearbyStops.length,
                              separatorBuilder: (_, __) => Gap(screenHeight * 0.008),
                              itemBuilder: (context, index) {
                                final stop = _nearbyStops[index];
                                return InkWell(
                                  onTap: () {
                                    // Navigate to stop details when available
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.all(screenWidth * 0.035),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.location_on, color: Colors.blue),
                                        Gap(screenWidth * 0.03),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    stop.name,
                                                    style: TextStyle(
                                                      fontSize: screenWidth * 0.045,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${stop.distanceMeters.toStringAsFixed(0)} m',
                                                    style: TextStyle(
                                                      color: Colors.grey[700],
                                                      fontSize: screenWidth * 0.034,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Gap(screenHeight * 0.004),
                                              Wrap(
                                                spacing: screenWidth * 0.025,
                                                runSpacing: screenHeight * 0.004,
                                                children: stop.arrivals.map((a) {
                                                  return Container(
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: screenWidth * 0.03,
                                                      vertical: screenHeight * 0.004,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xFFE3F2FD),
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    child: Text('Route ${a.route} • ${a.eta}'),
                                                  );
                                                }).toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
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
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (idx) {
            setState(() => _selectedIndex = idx);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.star_border), label: 'Favorites'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
    );
  }
}

class NearbyStop {
  final String name;
  final double distanceMeters;
  final List<Arrival> arrivals;

  NearbyStop({required this.name, required this.distanceMeters, required this.arrivals});
}

class Arrival {
  final String route;
  final String eta; // e.g., "3 min", "Due"

  Arrival({required this.route, required this.eta});
}
