import 'package:ecommerce_mobile/layouts/master_screen.dart';
import 'package:ecommerce_mobile/model/activity.dart';
import 'package:ecommerce_mobile/model/cart_provider.dart';
import 'package:ecommerce_mobile/model/product.dart';
import 'package:ecommerce_mobile/model/rewardrule.dart';
import 'package:ecommerce_mobile/model/search_result.dart';
import 'package:ecommerce_mobile/model/user.dart';
import 'package:ecommerce_mobile/model/useractivity.dart';
import 'package:ecommerce_mobile/providers/activity_provider.dart';
import 'package:ecommerce_mobile/providers/rewardrule_provider.dart';
import 'package:ecommerce_mobile/providers/user_provider.dart';
import 'package:ecommerce_mobile/providers/useractivity_provider.dart';
import 'package:ecommerce_mobile/providers/utils.dart';
import 'package:ecommerce_mobile/screens/activity_details_screen.dart';
import 'package:ecommerce_mobile/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_mobile/providers/product_provider.dart';

class ActivityList extends StatefulWidget {
  const ActivityList({super.key});

  @override
  State<ActivityList> createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {
  late UseractivityProvider useractivityProvider;
  late RewardRuleProvider rewardRuleProvider;
  TextEditingController statusController = TextEditingController();

  SearchResult<UserActivity>? userActivityData;
  SearchResult<RewardRule>? rewardRules;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  
  }

  @override
  void initState() {
    super.initState();
    useractivityProvider = context.read<UseractivityProvider>();
    rewardRuleProvider = context.read<RewardRuleProvider>();
    loadData();
  }

  void loadData() async {
    var userActivity = await useractivityProvider.get();
    this.userActivityData = userActivity;

    var rewards = await rewardRuleProvider.get();
    this.rewardRules = rewards;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //  final Map<int, int> pointsByActivity = {};
    // if (rewardRules != null && rewardRules!.items != null) {
    //   for (var rule in rewardRules!.items!) {
    //     if (rule.activityId != null && rule.numberOfPoints != null) {
    //       pointsByActivity[rule.activityId!] = rule.numberOfPoints!;
    //     }
    //   }
    // }
    return MasterScreen(
      title: "Activity List",
      child: Center(
        child: Column(
          children: [
            _buildSearch(),
            _buildResultView(),
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       const Text("Broj bodova po aktivnosti:", style: TextStyle(fontWeight: FontWeight.bold)),
            //       ...pointsByActivity.entries.map((e) => Text("Aktivnost ID ${e.key}: ${e.value} bodova")),
            //     ],
            //   ),
            // ),
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
                  hintText: "Search",
                  border: OutlineInputBorder(),
                ),
                controller: statusController,
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () async {
                var filter = {
                  "StatusActivity": statusController.text,
                };
                var useractivity = await useractivityProvider.get(filter: filter);
                this.userActivityData = useractivity;
                setState(() {});
              },
              child: Text("Search"),
            ),
            SizedBox(width: 10),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityDetailsScreen()));
            }, child: Text("New activity"))
          ],
        ));
  }
  

  Widget _buildResultView() {
    return Expanded(child: Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Container(
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
      ),
    ));
  }



    List<Widget> _buildProductCardList() {
    if (userActivityData == null || userActivityData?.items?.length == 0) {
      return [Text("Loading...")];
    }

    List<Widget> list = userActivityData!.items!.map((x) => Container(
      child: Column(
        children: [
          Text(x.korisnik?.firstName ?? ''),
          Text(x.korisnik?.lastName ?? ''),
          Text(x.activity?.name ?? ''),
          Text(x.statusActivity ?? ''),
        ],
      ),
    )).cast<Widget>().toList();
    
    return list;
  }

}
