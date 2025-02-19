// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:testapp/models/banner_model.dart';


// class BannerViewModel with ChangeNotifier {
//   List<BannerModel> _banners = [];
//   bool _isLoading = false;

//   List<BannerModel> get banners => _banners;
//   bool get isLoading => _isLoading;

//   Future<void> fetchBanners() async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       final response = await http.get(
//         Uri.parse('https://admin.kushinirestaurant.com/api/banners/'),
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         _banners = data.map((json) => BannerModel.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to load banners');
//       }
//     } catch (e) {
//       print('Error fetching banners: $e');
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testapp/models/banner_model.dart';


class BannerViewModel with ChangeNotifier {
  List<BannerModel> _banners = [];
  bool _isLoading = false;
  int _currentIndex = 0;

  List<BannerModel> get banners => _banners;
  bool get isLoading => _isLoading;
  int get currentIndex => _currentIndex;

  Future<void> fetchBanners() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://admin.kushinirestaurant.com/api/banners/'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _banners = data.map((json) => BannerModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load banners');
      }
    } catch (e) {
      print('Error fetching banners: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}