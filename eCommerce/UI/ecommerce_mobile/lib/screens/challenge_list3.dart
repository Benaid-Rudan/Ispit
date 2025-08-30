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

class ChallengeList3 extends StatefulWidget {
  const ChallengeList3({super.key,this.user});
  final User? user;

  @override
  State<ChallengeList3> createState() => _ChallengeList3State();
}

class _ChallengeList3State extends State<ChallengeList3> {
  late UserChallengeProvider userChallengeProvider;
  late PeerChallengeProvider peerChallengeProvider;

  TextEditingController statusIzazovaController = TextEditingController();
  TextEditingController tipIzazovaController = TextEditingController();
  TextEditingController datumController = TextEditingController();

  SearchResult<PeerChallenge>? peerChallengeData;
  SearchResult<UserChallenge>? userChallengeData;
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

  void loadData() async {
    var userChallenge = await userChallengeProvider.get(filter: {
      "StatusIzazova": "Prihvacen",  
    });
    this.userChallengeData = userChallenge;

    var peerChallenge = await peerChallengeProvider.get();
    this.peerChallengeData = peerChallenge;
    _filterReceivedChallenges();
    setState(() {});
  }

  void _filterReceivedChallenges(){
    var currentUserId = widget.user?.id;
    listReceived = peerChallengeData?.items?.where((x)=> x.statusPeera == "Poslan" &&
    x.izazvaniId == currentUserId && x.izazivacId != currentUserId).toList() ?? [];
  }

  Future<void> updateChallenge(PeerChallenge challenge, String status) async{
    await peerChallengeProvider.update(challenge.peerChallengeId!, {"statusPeera":status});
    loadData();
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
                  hintText: "Datum izazova",
                  border: OutlineInputBorder(),
                ),
                controller: datumController,
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () async {
                var filter = {
                  "StatusIzazova": statusIzazovaController.text,
                  "TipIzazova": tipIzazovaController.text,
                  "DatumPrihvatanja": datumController.text,
                };
                var challenge = await userChallengeProvider.get(filter: filter);
                this.userChallengeData = challenge;
                setState(() {});
              },
              child: Text("Search"),
            ),
            SizedBox(width: 10),
            ElevatedButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChallengeDetails2Screen()
                ));
            }, child: Text("New"),)
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
                Text("Received challenges"),
                const SizedBox(height: 20,),
                _buildReceivedChallenges()
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
          Text(x.statusIzazova.toString()),
          Text(x.challenge!.tipIzazova!.toString()),
          Text(x.datumPrihvatanja!.toIso8601String()),
        ],
      ),
    )).cast<Widget>().toList();
    
    return list;
  }

}
