import 'package:flutter/material.dart';
import 'package:freelancing/constant/colors.dart';


class freelancerProfile extends StatefulWidget {
  const freelancerProfile({super.key});

  @override
  State<freelancerProfile> createState() => _freelancerProfileState();
}

class _freelancerProfileState extends State<freelancerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_back,
                  size: 40,
                ),
              ),
              Text(
                'Profile',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, color: IndigoDye),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Image.asset(
                  'assets/images/profile.png',
                  height: 30,
                  width: 30,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Image.asset(
              'assets/images/profile.png',
              height: 100,
              width: 100,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100, right: 100),
            child: TextButton(
                onPressed: () {},
                child: Text(
                  'Edit profile image',
                  style: TextStyle(color: Aquamarine, fontSize: 15),
                )),
          ),
          ListTile(
            title: Text(
              'Name',
              style: TextStyle(fontSize: 25),
            ),
            subtitle: Text('Helena Hills'),
            trailing: IconButton(
                onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
          ),
          ListTile(
            title: Text(
              'username',
              style: TextStyle(fontSize: 25),
            ),
            subtitle: Text('Helena24'),
            trailing: IconButton(
                onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
          ),
          ListTile(
            title: Text(
              'Email',
              style: TextStyle(fontSize: 25),
            ),
            subtitle: Text('Helena24@gmail.com'),
            trailing: IconButton(
                onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  child: Text(
                    'Links',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'website.net',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'mylink.net',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'yourlink.net',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () {
                          // Handle the add link action
                        },
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            '+ Add link',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              'Bio',
              style: TextStyle(fontSize: 25),
            ),
            subtitle: Text('A description of this user'),
            trailing: IconButton(
                onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
          ),
          ListTile(
            title: Text(
              'Category',
              style: TextStyle(fontSize: 25),
            ),
            subtitle: Text('IT'),
            trailing: IconButton(
                onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
          ),
          ListTile(
            title: Text(
              'Sub_cat',
              style: TextStyle(fontSize: 25),
            ),
            subtitle: Text('front-end'),
            trailing: IconButton(
                onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
          ),
        ],
      ),
    );
  }
}
