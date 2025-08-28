import 'package:ecommerce_mobile/layouts/master_screen.dart';
import 'package:ecommerce_mobile/model/search_result.dart';
import 'package:ecommerce_mobile/model/user.dart';
import 'package:ecommerce_mobile/model/peer_challenge.dart';
import 'package:ecommerce_mobile/model/user_challenge.dart';
import 'package:ecommerce_mobile/providers/peer_challenge_provider.dart';
import 'package:ecommerce_mobile/providers/user_challenge_provider.dart';
import 'package:ecommerce_mobile/screens/challenges_details_screen.dart';
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

  final statusController = TextEditingController();
  final tipIzazovaController = TextEditingController();
  final datumController = TextEditingController();

  SearchResult<PeerChallenge>? data;
  SearchResult<UserChallenge>? userData;
  List<PeerChallenge> receivedChallenges = [];

  @override
  void initState() {
    super.initState();
    peerChallengeProvider = context.read<PeerChallengeProvider>();
    userChallengeProvider = context.read<UserChallengeProvider>();
    _loadData();
  }

  Future<void> _loadData({Map<String, String>? filter}) async {
    userData = await userChallengeProvider.get(filter: filter ?? {});
    data = await peerChallengeProvider.get(filter: {});
    _filterReceived();
  }

  void _filterReceived() {
    final currentUserId = widget.user?.id ?? 1;
    receivedChallenges = data?.items
            ?.where((x) =>
                x.statusPeer == "Poslan" &&
                x.izazvaniId == currentUserId &&
                x.izazivacId != currentUserId)
            .toList() ??
        [];
    setState(() {});
  }

  Future<void> _updateChallenge(PeerChallenge challenge, String status) async {
    try {
      await peerChallengeProvider.update(challenge.peerChallengeId!, {"statusPeer": status});
      await _loadData();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Challenges",
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearch(),
            _buildUserChallenges(),
            const SizedBox(height: 10),
            const Text("Received Challenges:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildReceivedChallenges(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(child: TextField(controller: statusController, decoration: const InputDecoration(hintText: "Status"))),
          const SizedBox(width: 10),
          Expanded(child: TextField(controller: tipIzazovaController, decoration: const InputDecoration(hintText: "Tip"))),
          const SizedBox(width: 10),
          Expanded(child: TextField(controller: datumController, decoration: const InputDecoration(hintText: "Datum"))),
          ElevatedButton(
            onPressed: () => _loadData(filter: {
              "StatusIzazova": statusController.text,
              "TipIzazova": tipIzazovaController.text,
              "DatumIzazova": datumController.text,
            }),
            child: const Text("Search"),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChallengeDetailsScreen())),
            child: const Text("New"),
          ),
        ],
      ),
    );
  }

  Widget _buildReceivedChallenges() {
    if (receivedChallenges.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(10),
        child: Text("No received challenges."),
      );
    }
    return Column(
      children: receivedChallenges.map((x) {
        return Card(
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Challenge ID: ${x.challengeId ?? 'Unknown'}"),
                Text('Status: ${x.statusPeer ?? "Unknown"}'),
                Text('Date: ${x.datumKreiranja?.toIso8601String() ?? ""}'),
                Text('From User ID: ${x.izazivacId ?? "Unknown"}'),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => _updateChallenge(x, "Prihvacen"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      child: const Text("Accept"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _updateChallenge(x, "Odbijen"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text("Reject"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUserChallenges() {
    if (userData == null || userData!.items?.isEmpty == true) {
      return const Center(child: Text("No challenges found."));
    }
    return SizedBox(
      height: 300,
      child: GridView.builder(
        itemCount: userData!.items!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1.2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          final challenge = userData!.items![index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ID: ${challenge.challengeId ?? 'N/A'}", style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text("Status: ${challenge.statusIzazov ?? 'N/A'}"),
                  Text("Tip: ${challenge.challenge?.tipIzazova ?? 'N/A'}"),
                  if (challenge.datumPrihvatanja != null)
                    Text("Date: ${challenge.datumPrihvatanja!.toIso8601String().split('T')[0]}"),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ChallengeDetailsScreen()),
                    ),
                    child: const Text("Details", style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
