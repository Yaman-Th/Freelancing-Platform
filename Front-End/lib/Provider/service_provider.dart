import 'dart:io';
import 'package:flutter/material.dart';
import 'package:freelancing/Server/service.dart';
import 'package:freelancing/models/service.dart';

class ServiceProvider with ChangeNotifier {
  final List<Service> _services = [];
  List<Service> get services => _services;
  final ServiceService _apiService;

  ServiceProvider(this._apiService);

  Future<void> addService(Service service, File imageFile) async {
    try {
      final newService =
          await _apiService.uploadServiceWithImage(service, imageFile);
      _services.add(newService);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateService(
      int index, Service updatedService, File imageFile) async {
    try {
      final newService =
          await _apiService.uploadServiceWithImage(updatedService, imageFile);
      _services[index] = newService;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void deleteService(int index) {
    _services.removeAt(index);
    notifyListeners();
  }

  Future<void> fetchServices() async {
    try {
      List<Service> data = await _apiService.getAllServices();
      _services.clear();
      _services.addAll(data);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
