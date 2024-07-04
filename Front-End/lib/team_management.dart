import 'package:flutter/material.dart';

class TeamManagement extends StatefulWidget {
  const TeamManagement({super.key});

  @override
  State<TeamManagement> createState() {
    return TeamManagementState();
  }
}

class TeamManagementState extends State<TeamManagement> {
  final teamNameController = TextEditingController();
  final freelancerNameController = TextEditingController();
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Team Management',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/Avatar.jpg'),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Create your own team',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 70,
                width: 350,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurface,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextField(
                    controller: teamNameController,
                    cursorColor: Theme.of(context).colorScheme.background,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.background,
                        ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: ('Enter your Team Name'),
                      hintStyle:
                          Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Theme.of(context).colorScheme.background,
                              ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                height: 70,
                width: 350,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondary,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextField(
                    controller: freelancerNameController,
                    cursorColor: Theme.of(context).colorScheme.background,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.background,
                        ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).colorScheme.background,
                      ),
                      hintText: ('Freelancer Name'),
                      hintStyle:
                          Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Theme.of(context).colorScheme.background,
                              ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: 370,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      child: Text(
                        'Create',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.background,
                            ),
                      ),
                    ),
                  )),
                  const SizedBox(height:20,),
              SizedBox(
                width: 320,
                child: Text('Team names',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary)),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 200,
                child: ListView(
                  children:  [
                    ListTile(
                      leading: Text('1',  style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            )),
                      title: Text('Ahmad Mohsen',style:Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),),
                      trailing: Text('accept',
                          style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Colors.green,
                            )),
                    ),
                    ListTile(
                      leading: Text('2',  style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            )),
                      title: Text('Khaled Kashmiri',  style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            )),
                      trailing: Text('pending',
                          style:Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Colors.orange,
                            )),
                    ),
                    ListTile(
                      leading: Text('3',  style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            )),
                      title: Text('Othamn Shisha',  style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            )),
                      trailing: Text('pending',
                          style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Colors.orange,
                            )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
