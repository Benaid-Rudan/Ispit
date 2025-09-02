import 'package:ecommerce_mobile/layouts/master_screen.dart';
import 'package:ecommerce_mobile/model/cart_provider.dart';
import 'package:ecommerce_mobile/model/peer_challenge.dart';
import 'package:ecommerce_mobile/model/product.dart';
import 'package:ecommerce_mobile/model/search_result.dart';
import 'package:ecommerce_mobile/model/user.dart';
import 'package:ecommerce_mobile/model/user_challenge.dart';
import 'package:ecommerce_mobile/providers/peer_challenge_provider.dart';
import 'package:ecommerce_mobile/providers/user_challenge_provider.dart';
import 'package:ecommerce_mobile/providers/utils.dart';
import 'package:ecommerce_mobile/screens/challenge_details.dart';
import 'package:ecommerce_mobile/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_mobile/providers/product_provider.dart';

class ChallengeListScreen extends StatefulWidget {
  const ChallengeListScreen({super.key, this.user});
  final User? user;

  @override
  State<ChallengeListScreen> createState() => _ChallengeListScreenState();
}

class _ChallengeListScreenState extends State<ChallengeListScreen> {
  late PeerChallengeProvider peerChallengeProvider;
  late UserChallengeProvider userChallengeProvider;


  TextEditingController statusController = TextEditingController();
  TextEditingController tipController = TextEditingController();
  TextEditingController datumController = TextEditingController();

  SearchResult<PeerChallenge>? data;
  SearchResult<UserChallenge>? userChallengeData;
  List<PeerChallenge> listReceived = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  
  }

  @override
  void initState() {
    super.initState();
    peerChallengeProvider = context.read<PeerChallengeProvider>();
    userChallengeProvider = context.read<UserChallengeProvider>();
    loadData();
  }
  
  Future<void> updateChallenge(PeerChallenge challenge, String status)async{
    await peerChallengeProvider.update(challenge.peerChallengeId!, {"statusPeera":status});
    loadData();
  }

  void _filterReceivedChallenges(){
    var currentUserId = widget.user?.id;
    listReceived = data?.items?.where((x)=>x.statusPeera == "Poslan" &&
    x.izazvaniId == currentUserId && x.izazivacId != currentUserId).toList() ?? [];
  }

  void loadData() async {
    var peerChallenge = await peerChallengeProvider.get();
    this.data = peerChallenge;

    var userChallenge = await userChallengeProvider.get(filter: {
      "statusIzazova":"Prihvacen"
    });
    this.userChallengeData = userChallenge;

    _filterReceivedChallenges();

    setState(() {});
  }

  

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Challenge List",
      child: Center(
        child: Column(
          children: [
            _buildSearch(),
            _buildResultView()
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Status",
                  border: OutlineInputBorder(),
                ),
                controller: statusController,
              ),
            ),
            SizedBox(width: 10),

            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Tip izazova",
                  border: OutlineInputBorder(),
                ),
                controller: tipController,
              ),
            ),
            SizedBox(width: 10),

            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Datum",
                  border: OutlineInputBorder(),
                ),
                controller: datumController,
              ),
            ),
            SizedBox(width: 10),

            ElevatedButton(
              onPressed: () async {
                var filter = {
                  "StatusIzazova": statusController.text,
                  "TipIzazova": tipController.text,
                  "DatumPrihvatanja": datumController.text,
                };
                var user_challenge = await userChallengeProvider.get(filter: filter);
                this.userChallengeData = user_challenge;
                setState(() {});
              },
              child: Text("Search"),
            ),
            SizedBox(width: 10),
            ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChallengeDetailsScreen()));
            }, child: Text("New"))
          ],
        ));
  }
  

  Widget _buildResultView() {
    return Expanded(child: Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                  height: 500,
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 4 / 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 30
                    ),
                    scrollDirection: Axis.horizontal,
                    children: _buildProductCardList(),
                  ),
                ),
            const SizedBox(height: 20,),
            const Text("Received challenges:"),
            const SizedBox(height: 20,),
            _buildReceivedChallenges()
            
          ],
        ),
      ),
    ));
  }

    Widget _buildReceivedChallenges(){
      return Column(
        children: listReceived.map((x){
            return ListTile(
              title: Text("ChallengeID: ${x.challengeId ?? "Unknown"}"),
              subtitle: Text("From UserID: ${x.izazivacId ?? "Unknown"}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: () => updateChallenge(x, "Prihvacen"), icon: Icon(Icons.check, color: Colors.green),
                  tooltip: "Accept"),
                  IconButton(onPressed: () => updateChallenge(x, "Odbijen"), icon: Icon(Icons.close, color: Colors.red),
                  tooltip: "Reject"),
                ],
              ),

            );
        }).toList(),
      );
    }

    List<Widget> _buildProductCardList() {
    if (data == null || data?.items?.length == 0) {
      return [Text("Loading...")];
    }

    List<Widget> list = data!.items!.map((x) => Container(
      child: Column(
        children: [
          Text(x.peerChallengeId.toString()),
          Text(x.statusPeera.toString()),
          Text(x.challenge!.tipIzazova!.toString()),
          Text(x.datumKreiranja!.toIso8601String()),
          
        ],
      ),
    )).cast<Widget>().toList();
    
    return list;
  }

}