import 'package:ecommerce_mobile/main.dart';
import 'package:ecommerce_mobile/providers/user_provider.dart';
import 'package:ecommerce_mobile/screens/cart_screen.dart';
import 'package:ecommerce_mobile/screens/challenge_list.dart';
import 'package:ecommerce_mobile/screens/challenge_list2.dart';
import 'package:ecommerce_mobile/screens/product_details_screen.dart';
import 'package:ecommerce_mobile/screens/product_list.dart';
import 'package:ecommerce_mobile/model/user.dart';
import 'package:flutter/material.dart';

class MasterScreen extends StatefulWidget {
  const MasterScreen({super.key, required this.child, required this.title, this.user});
  final Widget child;
  final String title;
  final User? user;

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(title: Text('Back'), onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },),
            ListTile(title: Text('Products'), onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductList()));
            },),
            ListTile(title: Text('Product Details'), onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen()));
            },), ListTile(title: Text('Cart'), onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CartScreen()));
            },),
            ListTile(title: Text('Login'), onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },),
            ListTile(title: Text('Challenge'), onTap: () async {
              UserProvider userProvider = UserProvider();
              User user = await userProvider.getMe();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChallengeList(user: user)));
            },),
           
          ],
        ),
      ),
      body: widget.child,
    );
  }
}