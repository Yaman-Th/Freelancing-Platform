import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FreelancerDashboard extends StatefulWidget {
  const FreelancerDashboard({super.key});

  @override
  State<FreelancerDashboard> createState() {
    return FreelancerDashboardState();
  }
}

class FreelancerDashboardState extends State<FreelancerDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new,color:Theme.of(context).colorScheme.primary ,)),
        title: Text(
          'Dashboard',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                width: 250,
                height: 100,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurface,
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Amount',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.background,
                          ),
                    ),
                    Text(
                        NumberFormat.simpleCurrency(
                                locale: 'en_US', decimalDigits: 0)
                            .format(30450190),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.background,
                            ))
                  ],
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                width: 250,
                height: 100,
                decoration:  BoxDecoration(
                    color:Theme.of(context).colorScheme.onSecondary,
                    borderRadius:const BorderRadius.all(Radius.circular(15))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Project',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    Text('15',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ))
                  ],
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                width: 250,
                height: 100,
                decoration:  BoxDecoration(
                    color:Theme.of(context).colorScheme.onPrimary,
                    borderRadius:const BorderRadius.all(Radius.circular(15))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Service',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    Text('102',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 320,
                child: Text('History',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.primary)),
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (ctx, index) => ListTile(
                      title: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Text('Label 1',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              )),
                      const SizedBox(
                        width: 80,
                      ),
                      Text('Value 1 ',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              )),
                      const SizedBox(
                        width: 80,
                      ),
                      Text('Status',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ))
                    ],
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
