// ignore_for_file: use_build_context_synchronously

import 'package:fashion_app/common/models/api_error_model.dart';
import 'package:fashion_app/common/services/storage.dart';
import 'package:fashion_app/common/utils/environment.dart';
import 'package:fashion_app/common/widgets/error_modal.dart';
import 'package:fashion_app/src/addresses/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddressNotifier with ChangeNotifier {
  AddressModel? address;

  void setAddress(AddressModel a) {
    address = a;
    notifyListeners();
  }

  void clearAddress() {
    address = null;
    notifyListeners();
  }

  List<String> addressTypes = ['Home', 'School', 'Office'];

  String _addressType = '';

  void setAddressType(String type) {
    _addressType = type;
    notifyListeners();
  }

  String get addressType => _addressType;

  void clearAddressType() {
    _addressType = '';
  }

  bool _defaultToogle = false;

  void setDefaultToogle(bool d) {
    _defaultToogle = d;
    notifyListeners();
  }

  bool get defaultToogle => _defaultToogle;

  void clearDefaultToogle() {
    _defaultToogle = false;
  }

  void setAsDefault(int id, Function refetch, BuildContext context) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url =
          Uri.parse('${Environment.appBaseUrl}/api/address/default/?id=$id');

      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        refetch();
      } else if (response.statusCode == 404 || response.statusCode == 400) {
        var data = apiErrorFromJson(response.body);
        showErrorPopup(context, data.message, 'Error changing address', true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void deleteAddress(int id, Function refetch, BuildContext context) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url =
          Uri.parse('${Environment.appBaseUrl}/api/address/delete/?id=$id');

      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        refetch();
      } else if (response.statusCode == 404 || response.statusCode == 400) {
        var data = apiErrorFromJson(response.body);
        showErrorPopup(context, data.message, 'Error deleting address', true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
