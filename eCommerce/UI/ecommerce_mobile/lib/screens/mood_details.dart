import 'package:ecommerce_mobile/layouts/master_screen.dart';
import 'package:ecommerce_mobile/model/cart_provider.dart';
import 'package:ecommerce_mobile/model/mood.dart';
import 'package:ecommerce_mobile/model/product.dart';
import 'package:ecommerce_mobile/model/search_result.dart';
import 'package:ecommerce_mobile/providers/mood_provider.dart';
import 'package:ecommerce_mobile/providers/utils.dart';
import 'package:ecommerce_mobile/screens/mood_insert.dart';
import 'package:ecommerce_mobile/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_mobile/providers/product_provider.dart';

class MoodDetails extends StatefulWidget {
  const MoodDetails({super.key});

  @override
  State<MoodDetails> createState() => _MoodDetailsState();
}

class _MoodDetailsState extends State<MoodDetails> {
  
  late MoodProvider moodProvider;
  TextEditingController statusController = TextEditingController();
  TextEditingController imePrezimeController = TextEditingController();
  TextEditingController datumController = TextEditingController();

  SearchResult<Mood>? data;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  
  }

  @override
  void initState() {
    super.initState();
    moodProvider = context.read<MoodProvider>();
    loadData();
  }

  void loadData() async {
    var moods = await moodProvider.get();
    this.data = moods;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var sretan = data?.items?.where((x)=>x.status == "Sretan").length ?? 0;
    var tuzan = data?.items?.where((x)=>x.status == "Tuzan").length ?? 0;
    return MasterScreen(
      title: "Mood List",
      child: Center(
        child: Column(
          children: [
            _buildSearch(),
            _buildResultView(),
            Padding(padding: EdgeInsets.all(20),
            child: Text("Sretan moods: $sretan, Tuzan moods: $tuzan")
            ),
            
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
                  hintText: "Ime i Prezime",
                  border: OutlineInputBorder(),
                ),
                controller: imePrezimeController,
              ),
            ),
            SizedBox(width: 10),
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
                  "DatumEvidencije": datumController.text,
                  "imePrezime": imePrezimeController.text,
                  "Status": statusController.text,

                };
                var mood = await moodProvider.get(filter: filter);
                this.data = mood;
                setState(() {});
              },
              child: Text("Search"),
            ),
            SizedBox(width: 10),
            ElevatedButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MoodInsert()));
            }, child: Text("New Mood"))
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
    if (data == null || data?.items?.length == 0) {
      return [Text("Loading...")];
    }

    List<Widget> list = data!.items!.map((x) => Container(
      child: Column(
        children: [
          Text(x.moodId.toString()),
          Text("${x.korisnik!.firstName} ${x.korisnik?.lastName ?? ""}"),
          Text(x.datumEvidencije!.toIso8601String()),
          Text(x.status ?? ""),
        ],
      ),
    )).cast<Widget>().toList();
    
    return list;
  }

}
