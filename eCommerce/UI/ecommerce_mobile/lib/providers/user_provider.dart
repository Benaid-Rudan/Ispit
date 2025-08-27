import 'dart:convert';

import 'package:ecommerce_mobile/model/user.dart';
import 'package:ecommerce_mobile/providers/base_provider.dart';

class UserProvider extends BaseProvider<User> {
  UserProvider() : super("User");

  @override
  User fromJson(dynamic json) {
    return User.fromJson(json);
  }
  Future<User> getMe() async {
    final user = await super.getMe();
    return user;
  }
}
