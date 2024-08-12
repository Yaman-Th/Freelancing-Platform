import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelancing/models/service.dart';

// ServiceNotifier and serviceProvider
final serviceProvider = StateNotifierProvider<ServiceNotifier, List<Service>>((ref) {
  return ServiceNotifier();
});

class ServiceNotifier extends StateNotifier<List<Service>> {
  ServiceNotifier() : super([]);

  // Fetch all services (simulate fetching from a local database or list)
  Future<void> fetchServices() async {
    try {
      List<Service> services = [
        Service(id: 1, title: "Logo Design", description: "Design a company logo", deliveryDays: 3, price: 150.0, categoryId: 1, image: "path/to/image1.png"),
        Service(id: 2, title: "SEO Optimization", description: "Optimize a website for search engines", deliveryDays: 5, price: 300.0, categoryId: 2, image: "path/to/image2.png"),
        // Add more services as needed
      ];
      state = services;
    } catch (e) {
      // Handle error
    }
  }

  // Add a new service
  Future<void> addService(Service service) async {
    try {
      final newService = Service(
        id: state.length + 1,
        title: service.title,
        description: service.description,
        deliveryDays: service.deliveryDays,
        price: service.price,
        categoryId: service.categoryId,
        image: service.image,
      );
      state = [...state, newService];
    } catch (e) {
      // Handle error
    }
  }

  // Update an existing service
  Future<void> updateService(int index, Service updatedService) async {
    try {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index)
            updatedService
          else
            state[i],
      ];
    } catch (e) {
      // Handle error
    }
  }

  // Delete a service by index
  void deleteService(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i],
    ];
  }
}
