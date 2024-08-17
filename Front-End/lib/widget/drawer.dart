import 'package:flutter/material.dart';
import 'package:freelancing/Auth/login.dart';
import 'package:freelancing/Screens/freelancer_orders.dart';
import 'package:freelancing/Screens/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'package:freelancing/Server/auth_service.dart';

class NavBar extends StatelessWidget {
  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  @override
  Widget build(context) {
    return FutureBuilder<String?>(
        future: getEmail(),
        builder: (context, snapshot) {
          String? email = snapshot.data;

          return Drawer(
            backgroundColor: Colors.white,
            elevation: 0.0,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(
                    '',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  accountEmail: Text(
                    '',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  decoration: const BoxDecoration(
                      color: Colors.black87,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/Avatar.png"))),
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: Text(
                    'email',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Email: $email',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                ),
                                // Replace with the actual email variable
                                // Display other login information as needed
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.shopping_basket),
                  title: Text(
                    'orders',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => OrdersScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(
                    'Profile',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) =>const ClientProfile()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: Text(
                    'logOut',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  onTap: () async {
                    AuthService service = AuthService();
                    await service.logoutUser();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                )
              ],
            ),
          );
        });
  }
}
