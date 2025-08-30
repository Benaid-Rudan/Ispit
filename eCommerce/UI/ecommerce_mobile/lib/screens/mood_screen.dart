import 'package:ecommerce_mobile/layouts/master_screen.dart';
import 'package:ecommerce_mobile/model/cart_provider.dart';
import 'package:ecommerce_mobile/model/mood.dart';
import 'package:ecommerce_mobile/model/product.dart';
import 'package:ecommerce_mobile/model/search_result.dart';
import 'package:ecommerce_mobile/providers/mood_provider.dart';
import 'package:ecommerce_mobile/providers/utils.dart';
import 'package:ecommerce_mobile/screens/mood_details_screen.dart';
import 'package:ecommerce_mobile/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_mobile/providers/product_provider.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  // late ProductProvider productProvider;
  // late CartProvider cartProvider;
  late MoodProvider moodProvider;


  // TextEditingController searchController = TextEditingController();
  TextEditingController korisnikController = TextEditingController();
  TextEditingController raspolozenjeController = TextEditingController();
  TextEditingController datumController = TextEditingController();
  
  // SearchResult<Product>? data;
  SearchResult<Mood>? moodSearchResult;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  
  }

  @override
  void initState() {
    super.initState();
    moodProvider = context.read<MoodProvider>();
    // cartProvider = context.read<CartProvider>();
    loadData();
  }

  void loadData() async {
    moodSearchResult = await moodProvider.get();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var sretan = moodSearchResult?.items?.where((x)=> x.statusRaspolozenja == "Sretan").length ?? 0;
    return MasterScreen(
      title: "Mood List",
      child: Center(
        child: Column(
          children: [
            _buildSearch(),
            _buildResultView(),
            Padding(padding: EdgeInsets.all(8.0),
            child: Text("Moods sretan: $sretan"),
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
                  hintText: "Korisnik",
                  border: OutlineInputBorder(),
                ),
                controller: korisnikController,
              ),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Raspolozenje",
                  border: OutlineInputBorder(),
                ),
                controller: raspolozenjeController,
              ),
            ),
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
                  "IsKorisnikIncluded": true,
                  "imePrezime": korisnikController.text,
                  "StatusRaspolozenja": raspolozenjeController.text,
                  "DatumEvidencije": datumController.text,

                };
                // debugPrint(filter.toString());
                var moods = await moodProvider.get(filter: filter);
                // debugPrint(moods.items?.firstOrNull?.name);
                this.moodSearchResult = moods;
                setState(() {});
              },
              child: Text("Search"),
            ),
            SizedBox(width: 10),
            ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MoodDetailsScreen(),
                ),
              );
            },
            child: const Text("New"),
          ),
            
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
                  childAspectRatio: 9 / 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 80
                ),
                scrollDirection: Axis.horizontal,
                children: _buildProductCardList(),
              ),
            ),
      ),
    ));
  }



    List<Widget> _buildProductCardList() {
    // final items = moodSearchResult?.items ?? [];
    // final sretan = moodSearchResult?.items?.where((e) => e.statusRaspolozenja == "Sretan").length ?? 0;
    // final tuzan = moodSearchResult?.items?.where((e) => e.statusRaspolozenja == "Tuzan").length ?? 0;
    // final umoran = moodSearchResult?.items?.where((e) => e.statusRaspolozenja == "Umoran").length ?? 0;
    // if (moodSearchResult == null || moodSearchResult?.items?.length == 0) {
    //   return [Text("Loading...")];
    // }

    List<Widget> list = moodSearchResult!.items!.map((x) => Container(
      // onTap: () {
      //   Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (context) => MoodDetailsScreen(mood: x),
      //     ),
      //   );
      // },
      
      child: Column(
        children: [
          
          Text("${x.korisnik?.firstName} ${x.korisnik?.lastName!}"),
          Text(x.statusRaspolozenja ?? "No mood status"),
          Text(x.opis ?? "No description"),
          Text(x.datumEvidencije?.toIso8601String() ?? "No date"),
          
        ],
        
      ),
    )).cast<Widget>().toList();
    
    // list.add(
    //   Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Text("Sretan: $sretan, Tužan: $tuzan, Umoran: $umoran"),
    //   ),
    // );

    return list;
  }

}
