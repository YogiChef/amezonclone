import 'package:flutter/material.dart';
import '../auth/splash_page.dart';
import '../global/global.dart';
import '../orders/order_page.dart';
import '../pages/home_page.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  sharedPreferences!.getString('photoUrl')!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  sharedPreferences!.getString('name')!,
                  style: TextStyle(
                      letterSpacing: 1,
                      fontSize: 20,
                      color: Colors.cyan.shade600,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.home,
                        color: Colors.grey,
                      ),
                      title: const Text(
                        'Home',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      },
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.description,
                        color: Colors.grey,
                      ),
                      title: const Text(
                        'Orders',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OrderPage()));
                      },
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.no_backpack,
                        color: Colors.grey,
                      ),
                      title: const Text(
                        'Not Yet Received Orders',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      onTap: () {},
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.history,
                        color: Colors.grey,
                      ),
                      title: const Text(
                        'History',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      onTap: () {},
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      title: const Text(
                        'Search',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      onTap: () {},
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.grey,
                      ),
                      title: const Text(
                        'Sign Out',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      onTap: () {
                        auth.signOut();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SplashPage()));
                      },
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
