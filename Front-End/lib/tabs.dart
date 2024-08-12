import 'package:flutter/material.dart';
import 'package:freelancing/DashboardScreens/freelancer_dashboard.dart';
import 'package:freelancing/main.dart';
import 'package:freelancing/post_management.dart';
import 'package:freelancing/service_management.dart';
import 'package:freelancing/team_management.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => TabsScreenState();
}

class TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const FreelancerDashboard(),
      const ServiceManagement(),
      const PostManagement(),
       const TeamManagement(),
    ];

    List<String> pageTitles = [
      'Dashboard',
      'Service Management',
      'Post Management',
      'Team Management',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor:colorScheme.background,
        elevation:0.0,
        toolbarHeight: 70.0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).colorScheme.background,
            size:20,
          ),
        ),
        title: Text(
          pageTitles[_selectedPageIndex],
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.background,
                fontSize: 24
              ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius:const BorderRadius.only(bottomLeft:Radius.circular(20),bottomRight:Radius.circular(20)),
            gradient:LinearGradient(colors: 
            [colorScheme.onSecondary,colorScheme.onSurface,],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter            
            )
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/Avatar.png',),
              
            ),
          ),
        ],
      ),
      body: pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        backgroundColor: Theme.of(context).colorScheme.background,
        selectedItemColor: Theme.of(context).colorScheme.onSurface,
        unselectedItemColor:
            Theme.of(context).colorScheme.onSecondary,
            type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            label: 'Service',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_2_rounded),
            label: 'Teams',
          ),
        ],
      ),
    );
  }
}
