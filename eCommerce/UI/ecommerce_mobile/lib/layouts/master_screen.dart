import 'package:ecommerce_mobile/main.dart';
import 'package:ecommerce_mobile/providers/user_provider.dart';
import 'package:ecommerce_mobile/screens/cart_screen.dart';
import 'package:ecommerce_mobile/screens/challenge_list.dart';
import 'package:ecommerce_mobile/screens/challenge_list2.dart';
import 'package:ecommerce_mobile/screens/challenge_list3.dart';
import 'package:ecommerce_mobile/screens/product_details_screen.dart';
import 'package:ecommerce_mobile/screens/product_list.dart';
import 'package:flutter/material.dart';

class MasterScreen extends StatefulWidget {
  const MasterScreen({super.key, required this.child, required this.title});
  final Widget child;
  final String title;

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
            ListTile(title: Text('login'), onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },),

              ListTile(title: Text('Challenge3'), onTap: () async {
               var userProvider = await UserProvider();
               var user = await userProvider.getCurrent();
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChallengeList3(user:user)));
             },),

            // ListTile(title: Text('Challenges2'), onTap: () async {
            //   var userProvider = UserProvider();
            //   var user = await userProvider.getCurrent();
            //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Challenge2List(user:user)));
            // },),

            ListTile(title: Text('Challenges'), onTap: () async {
              var userProvider = UserProvider();
              var user = await userProvider.getCurrent();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChallengeList(user: user)));
            },),
          ],
        ),
      ),
      body: widget.child,
    );
  }
}