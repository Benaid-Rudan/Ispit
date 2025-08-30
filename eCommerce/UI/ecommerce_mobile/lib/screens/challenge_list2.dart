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
import 'package:ecommerce_mobile/screens/challenge_details2_screen.dart';
import 'package:ecommerce_mobile/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_mobile/providers/product_provider.dart';

class Challenge2List extends StatefulWidget {
  const Challenge2List({super.key, this.user});
  final User? user;
  @override
  State<Challenge2List> createState() => _Challenge2ListState();
}

class _Challenge2ListState extends State<Challenge2List> {
  
  late UserChallengeProvider userChallengeProvider;
  late PeerChallengeProvider peerChallengeProvider;

  TextEditingController statusIzazovaController = TextEditingController();
  TextEditingController tipIzazovaController = TextEditingController();
  TextEditingController datumController = TextEditingController();

  SearchResult<UserChallenge>? userChallengeData;
  SearchResult<PeerChallenge>? peerChallengeData;

  List<PeerChallenge> listReceived = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  
  }

  @override
  void initState() {
    super.initState();
    userChallengeProvider = context.read<UserChallengeProvider>();
    peerChallengeProvider = context.read<PeerChallengeProvider>();
    loadData();
  }

  Future<void> updateChallenge(PeerChallenge challenge,String status) async {
    await peerChallengeProvider.update(challenge.peerChallengeId!, {"statusPeera":status});
    loadData();
  }
  void _filterReceivedChallenges(){
    var currentUserId = widget.user!.id;
    listReceived = peerChallengeData?.items?.where((x)=> x.statusPeera == "Poslan" &&
    x.izazvaniId == currentUserId && 
    x.izazivacId != currentUserId).toList() ?? [];
  }
  void loadData() async {
    var userChallenges = await userChallengeProvider.get(filter: {
      "StatusIzazova":"Prihvacen"
    });
    this.userChallengeData = userChallenges;

    var peerChallenges = await peerChallengeProvider.get();
    this.peerChallengeData = peerChallenges;

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
                  hintText: "Status izazova",
                  border: OutlineInputBorder(),
                ),
                controller: statusIzazovaController,
              ),
            ),
            SizedBox(width: 10),

            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Tip izazova",
                  border: OutlineInputBorder(),
                ),
                controller: tipIzazovaController,
              ),
            ),
            SizedBox(width: 10),

            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Datum prihvatanja",
                  border: OutlineInputBorder(),
                ),
                controller: datumController,
              ),
            ),
            SizedBox(width: 10),
            
            ElevatedButton(
              onPressed: () async {
                var filter = {
                  "TipIzazova": tipIzazovaController.text,
                  "StatusIzazova": statusIzazovaController.text,
                  "DatumPrihvatanja": datumController.text,

                };
                var userChallenge = await userChallengeProvider.get(filter: filter);
                this.userChallengeData = userChallenge;
                setState(() {});
              },
              child: Text("Search"),
            ),
            SizedBox(width: 10),

            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChallengeDetails2Screen()
              ));
            }, child: const Text("New"))
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
            const Text("Received challenges", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
            const SizedBox(height: 10,),
            _buildReceivedChallenges(),
          ],
        ),
      ),
    ));
  }

    Widget _buildReceivedChallenges() {
  return Column(
    children: listReceived.map((x) {
      return ListTile(
        title: Text("Challenge ID: ${x.challengeId ?? 'Unknown'}"),
        subtitle: Text('From User ID: ${x.izazivacId ?? "Unknown"}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.check, color: Colors.green),
              onPressed: () => updateChallenge(x, "Prihvacen"),
              tooltip: "Accept",
            ),
            IconButton(
              icon: Icon(Icons.close, color: Colors.red),
              onPressed: () => updateChallenge(x, "Odbijen"),
              tooltip: "Reject",
            ),
          ],
        ),
      );
    }).toList(),
  );
}

    List<Widget> _buildProductCardList() {
    if (userChallengeData == null || userChallengeData?.items?.length == 0) {
      return [Text("Loading...")];
    }

    List<Widget> list = userChallengeData!.items!.map((x) => Container(
      child: Column(
        children: [
          Text(x.userChallengeId.toString()),
          Text(x.challenge!.tipIzazova!.toString()),
          Text(x.statusIzazova.toString()),
          Text(x.datumPrihvatanja!.toIso8601String()),

        
        ],
      ),
    )).cast<Widget>().toList();
    
    return list;
  }

}
