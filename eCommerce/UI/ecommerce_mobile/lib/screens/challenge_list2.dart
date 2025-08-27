// import 'package:ecommerce_mobile/layouts/master_screen.dart';
// import 'package:ecommerce_mobile/model/search_result.dart';
// import 'package:ecommerce_mobile/model/user.dart';
// import 'package:ecommerce_mobile/model/peer_challenge.dart';
// import 'package:ecommerce_mobile/model/user_challenge.dart';
// import 'package:ecommerce_mobile/providers/peer_challenge_provider.dart';
// import 'package:ecommerce_mobile/providers/user_challenge_provider.dart';
// import 'package:ecommerce_mobile/screens/challenge_details_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ChallengeList extends StatefulWidget {
//   const ChallengeList({super.key, this.user});

//   final User? user;

//   @override
//   State<ChallengeList> createState() => _ChallengeListState();
// }

// class _ChallengeListState extends State<ChallengeList> {
//   late PeerChallengeProvider peerChallengeProvider;
//   late UserChallengeProvider userChallengeProvider;
  
//   TextEditingController datumController = TextEditingController();
//   TextEditingController tipIzazovaController = TextEditingController();
//   TextEditingController statusIzazovaController = TextEditingController();

//   SearchResult<PeerChallenge>? data;
//   SearchResult<UserChallenge>? userData;
//   List<PeerChallenge> acceptedChallenges = [];
//   List<PeerChallenge> pendingChallenges = [];
//   List<PeerChallenge> receivedChallenges = [];
//   bool isSearchActive = false;

//   @override
//   void initState() {
//     super.initState();
//     print("=== ChallengeList initState ===");
//     print("Received user: ${widget.user?.id}");
//     print("Received user username: ${widget.user?.username}");
//     peerChallengeProvider = context.read<PeerChallengeProvider>();
//     userChallengeProvider = context.read<UserChallengeProvider>();
//     loadData();
//   }

//   void loadData() async {
//     try {
//       var challenge = await userChallengeProvider.get(filter: {
//         "StatusIzazova": "",
//         "TipIzazova": "",
//         "DatumIzazova": ""
//       });
//       this.userData = challenge;
//       print("Loaded ${userData?.items?.length ?? 0} user challenges");
//       setState(() {});
//     } catch (e) {
//       print("Error loading data: $e");
//     }
//   }

//   Future<void> acceptChallenge(PeerChallenge challenge) async {
//     try {
//       print("=== Accepting challenge ===");
//       print("Challenge ID: ${challenge.peerChallengeId}");
//       print("Current status: ${challenge.status}");

//       await peerChallengeProvider.update(
//         challenge.peerChallengeId!,
//         {"status": "Prihvaćen"}
//       );
//       print("Challenge accepted successfully");
//       loadData();
//     } catch (e) {
//       print("Error accepting challenge: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error accepting challenge: $e"))
//       );
//     }
//   }

//   Future<void> rejectChallenge(PeerChallenge challenge) async {
//     try {
//       print("=== Rejecting challenge ===");
//       print("Challenge ID: ${challenge.peerChallengeId}");
//       print("Current status: ${challenge.status}");

//       await peerChallengeProvider.update(
//         challenge.peerChallengeId!,
//         {"status": "Odbijen"}
//       );
//       print("Challenge rejected successfully");
//       loadData();
//     } catch (e) {
//       print("Error rejecting challenge: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error rejecting challenge: $e"))
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MasterScreen(
//       title: "Challenges List",
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildSearch(),
//             SizedBox(height: 10),
//             _buildResultView(),
//             SizedBox(height: 20),
            
//             // Debug info
//             if (userData?.items != null) ...[
//               Padding(
//                 padding: EdgeInsets.all(10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Debug Info:", style: TextStyle(fontWeight: FontWeight.bold)),
//                     Text("Total user challenges: ${userData!.items!.length}"),
//                     Text("User ID: ${widget.user?.id}"),
//                   ],
//                 ),
//               ),
//             ]
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSearch() {
//     return Padding(
//       padding: EdgeInsets.all(10),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: "Tip izazova",
//                     border: OutlineInputBorder(),
//                   ),
//                   controller: tipIzazovaController,
//                 ),
//               ),
//               SizedBox(width: 10),
//               Expanded(
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: "Status izazova",
//                     border: OutlineInputBorder(),
//                   ),
//                   controller: statusIzazovaController,
//                 ),
//               ),
//               SizedBox(width: 10),
//               Expanded(
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: "Datum",
//                     border: OutlineInputBorder(),
//                   ),
//                   controller: datumController,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 10),
//           Row(
//             children: [
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     var filter = <String, String>{};
                    
//                     if (tipIzazovaController.text.isNotEmpty) {
//                       filter["TipIzazova"] = tipIzazovaController.text;
//                     }
//                     if (statusIzazovaController.text.isNotEmpty) {
//                       filter["StatusIzazova"] = statusIzazovaController.text;
//                     }
//                     if (datumController.text.isNotEmpty) {
//                       filter["DatumPrihvatanja"] = datumController.text;
//                     }

//                     try {
//                       debugPrint(filter.toString());
//                       var challenge = await userChallengeProvider.get(filter: filter);
//                       this.userData = challenge;
//                       setState(() {
//                         isSearchActive = true;
//                       });
//                     } catch (e) {
//                       print("Search error: $e");
//                     }
//                   },
//                   child: Text("Search"),
//                 ),
//               ),
//               SizedBox(width: 10),
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     tipIzazovaController.clear();
//                     statusIzazovaController.clear();
//                     datumController.clear();
//                     setState(() {
//                       isSearchActive = false;
//                     });
//                     loadData();
//                   },
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
//                   child: Text("Clear"),
//                 ),
//               ),
//               SizedBox(width: 10),
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => ChallengeDetailsScreen(),
//                     ));
//                   },
//                   child: const Text("New"),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildResultView() {
//     // KLJUČNA IZMJENA: Umjesto Expanded, koristimo Container sa fiksnom visinom
//     return Container(
//       width: double.infinity,
//       height: 600, // Fiksna visina umjesto Expanded
//       child: Padding(
//         padding: EdgeInsets.all(10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "All Challenges:",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
//             ),
//             SizedBox(height: 10),
//             Expanded( // Sada je OK koristiti Expanded jer imamo fiksnu visinu od Container-a
//               child: _buildChallengeGrid(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildChallengeGrid() {
//     if (userData == null || userData?.items?.isEmpty == true) {
//       return Center(
//         child: Text("No challenges found.", style: TextStyle(fontSize: 16))
//       );
//     }

//     return GridView.builder(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 1.2,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//       ),
//       itemCount: userData!.items!.length,
//       itemBuilder: (context, index) {
//         var challenge = userData!.items![index];
//         return Card(
//           elevation: 3,
//           child: Padding(
//             padding: EdgeInsets.all(8),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "ID: ${challenge.challengeId ?? 'N/A'}",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   "Status: ${challenge.statusIzazova ?? 'N/A'}",
//                   style: TextStyle(fontSize: 12),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   "Tip: ${challenge.challenge?.tipIzazova ?? 'N/A'}",
//                   style: TextStyle(fontSize: 12),
//                 ),
//                 SizedBox(height: 4),
//                 if (challenge.datumPrihvatanja != null)
//                   Text(
//                     "Datum: ${challenge.datumPrihvatanja!.toIso8601String().split('T')[0]}",
//                     style: TextStyle(fontSize: 10),
//                   ),
//                 Spacer(),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => ChallengeDetailsScreen(userChallenge: challenge),
//                     ));
//                   },
//                   child: Text("Details", style: TextStyle(fontSize: 12)),
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: Size(double.infinity, 30),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // Ove metode možete ukloniti jer sada koristite _buildResultView()
//   Widget _buildAcceptedChallenges() {
//     return Padding(
//       padding: EdgeInsets.all(10),
//       child: Text("Using _buildResultView() instead"),
//     );
//   }

//   Widget _buildPendingChallenges() {
//     return Container();
//   }

//   Widget _buildReceivedChallenges() {
//     return Container();
//   }
// }