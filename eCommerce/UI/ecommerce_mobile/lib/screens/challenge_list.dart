import 'package:ecommerce_mobile/layouts/master_screen.dart';
import 'package:ecommerce_mobile/model/search_result.dart';
import 'package:ecommerce_mobile/model/user.dart';
import 'package:ecommerce_mobile/model/peer_challenge.dart';
import 'package:ecommerce_mobile/model/user_challenge.dart';
import 'package:ecommerce_mobile/providers/peer_challenge_provider.dart';
import 'package:ecommerce_mobile/providers/user_challenge_provider.dart';
import 'package:ecommerce_mobile/screens/challenge_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChallengeList extends StatefulWidget {
  const ChallengeList({super.key, this.user});

  final User? user;

  @override
  State<ChallengeList> createState() => _ChallengeListState();
}

class _ChallengeListState extends State<ChallengeList> {
  late PeerChallengeProvider peerChallengeProvider;
  late UserChallengeProvider userChallengeProvider;

  TextEditingController datumController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController tipIzazovaController = TextEditingController();

  SearchResult<PeerChallenge>? data;
  SearchResult<UserChallenge>? userData;

  List<PeerChallenge> receivedChallenges = []; // Challenges received by current user

  bool isSearchActive = false;

  @override
  void initState() {
    super.initState();
    print("=== ProductList initState ===");
    print("Received user: ${widget.user?.id}");
    print("Received user username: ${widget.user?.username}");
    peerChallengeProvider = context.read<PeerChallengeProvider>();
    userChallengeProvider = context.read<UserChallengeProvider>();
    loadData();
  }

  void loadData() async {
    // Load UserChallenge data
    var challenge = await userChallengeProvider.get(filter: {
      "StatusIzazova": "Prihvaćen",
      "TipIzazova": "",
      "DatumIzazova": "",
      // "IzazvaniId": widget.user?.id
    });
    this.userData = challenge;
    
    // Also load PeerChallenge data for received challenges
    var peerChallenges = await peerChallengeProvider.get(filter: {
      "StatusIzazova": "",
      "TipIzazova": "",
      "DatumIzazova": ""
    });
    this.data = peerChallenges;
    
    print("=== DEBUG INFO ===");
    print("Total user challenges: ${userData?.items?.length ?? 0}");
    print("Total peer challenges: ${data?.items?.length ?? 0}");
    print("Current user ID: ${widget.user?.id}");
    
    // Filter challenges based on current user
    int? currentUserId = widget.user?.id ?? 1;
    
    if (data?.items != null) {
      // Received challenges: challenges received by current user from others (pending)
      receivedChallenges = data!.items!.where((x) =>
        x.status == "Poslan" &&
        x.izazvaniId == currentUserId &&
        x.izazivacId != currentUserId
      ).toList();
      
      print("Received challenges: ${receivedChallenges.length}");
    }
    
    setState(() {});
  }

  

  Future<void> acceptChallenge(PeerChallenge challenge) async {
    try {
      print("=== Accepting challenge ===");
      print("Challenge ID: ${challenge.peerChallengeId}");
      print("Current status: ${challenge.status}");

      await peerChallengeProvider.update(
        challenge.peerChallengeId!,
        {"status": "Prihvaćen"}
      );
      print("Challenge accepted successfully");
      loadData(); // Reload data after update
    } catch (e) {
      print("Error accepting challenge: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error accepting challenge: $e"))
      );
    }
  }

  Future<void> rejectChallenge(PeerChallenge challenge) async {
    try {
      print("=== Rejecting challenge ===");
      print("Challenge ID: ${challenge.peerChallengeId}");
      print("Current status: ${challenge.status}");

      await peerChallengeProvider.update(
        challenge.peerChallengeId!,
        {"status": "Odbijen"}
      );
      print("Challenge rejected successfully");
      loadData(); // Reload data after update
    } catch (e) {
      print("Error rejecting challenge: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error rejecting challenge: $e"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Challenges List",
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearch(),
            _buildResultView(),
            
            Text("Received Challenges (Waiting for your response):",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildReceivedChallenges(),
            
            // Debug info
            if (data?.items != null) ...[
              SizedBox(height: 20),
              Text("Debug Info:", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Total challenges: ${data!.items!.length}"),
              Text("User ID: ${widget.user?.id}"),
            ]
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
            ElevatedButton(
              onPressed: () async {
                var filter = {
                  "TipIzazova": tipIzazovaController.text,
                  "StatusIzazova": statusController.text,
                  "DatumPrihvatanja": datumController.text,
                };
                
                debugPrint(filter.toString());
                var challenge = await userChallengeProvider.get(filter: filter);
                this.userData = challenge;
                
                // Also update peer challenges for received challenges
                var peerChallenges = await peerChallengeProvider.get(filter: {});
                this.data = peerChallenges;
                
                // Update filtered challenges
                int? currentUserId = widget.user?.id ?? 1;
                if (data?.items != null) {
                  receivedChallenges = data!.items!.where((x) =>
                    x.status == "Poslan" &&
                    x.izazvaniId == currentUserId &&
                    x.izazivacId != currentUserId
                  ).toList();
                }
                
                setState(() {});
              },
              child: Text("Search"),
            ),
            Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChallengeDetailsScreen(),
                    ));
                  },
                  child: const Text("New"),
                ),
              ),
          ],
        ));
  }

  Widget _buildReceivedChallenges() {
    if (receivedChallenges.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Text("No received challenges."),
      );
    }
    return Container(
      child: Column(
        children: receivedChallenges.map((x) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Challenge ID: ${x.challengeId ?? 'Unknown'}"),
                  Text('Status: ${x.status ?? "Unknown"}'),
                  Text('Datum: ${x.datumKreiranja?.toIso8601String() ?? ""}'),
                  Text('From User ID: ${x.izazivacId ?? "Unknown"}'),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await acceptChallenge(x);
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        child: Text("Accept"),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () async {
                          await rejectChallenge(x);
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        child: Text("Reject"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
  
  Widget _buildResultView() {
    return Container(
      width: double.infinity,
      height: 300,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "All User Challenges:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
            ),
            SizedBox(height: 10),
            Expanded(
              child: _buildUserChallengeGrid(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserChallengeGrid() {
    if (userData == null || userData?.items?.isEmpty == true) {
      return Center(
        child: Text("No challenges found.", style: TextStyle(fontSize: 16))
      );
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: userData!.items!.length,
      itemBuilder: (context, index) {
        var challenge = userData!.items![index];
        return Card(
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ID: ${challenge.challengeId ?? 'N/A'}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "Status: ${challenge.statusIzazova ?? 'N/A'}",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 4),
                Text(
                  "Tip: ${challenge.challenge?.tipIzazova ?? 'N/A'}",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 4),
                if (challenge.datumPrihvatanja != null)
                  Text(
                    "Datum: ${challenge.datumPrihvatanja!.toIso8601String().split('T')[0]}",
                    style: TextStyle(fontSize: 10),
                  ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChallengeDetailsScreen(userChallenge: challenge),
                    ));
                  },
                  child: Text("Details", style: TextStyle(fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 30),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}