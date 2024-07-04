import 'package:flutter/material.dart';
import 'package:freelancing/DashboardScreens/freelancer_dashboard.dart';
import 'package:freelancing/post_management.dart';
import 'package:freelancing/service_management.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return TabsScreenState();
  }
}

class TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(context) {
    Widget activePage = const FreelancerDashboard();
    var activePageTitle = 'Dashboard';
    if (_selectedPageIndex == 1) {
      activePage = const ServiceManagement();
      activePageTitle = 'Service Management';
    }
    if (_selectedPageIndex == 2) {
      activePage = const PostManagement();
      activePageTitle = 'Post Management';
    }
    var leadingIcons = IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: Theme.of(context).colorScheme.primary,
        ));
    return Scaffold(
      appBar: AppBar(
        leading: leadingIcons,
        title: Text(
          activePageTitle,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/Avatar.jpg'),
            ),
          )
        ],
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
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
        ],
      ),
    );
  }
}
