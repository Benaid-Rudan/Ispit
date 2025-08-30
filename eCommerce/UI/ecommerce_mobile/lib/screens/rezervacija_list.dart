import 'package:ecommerce_mobile/layouts/master_screen.dart';
import 'package:ecommerce_mobile/model/cart_provider.dart';
import 'package:ecommerce_mobile/model/product.dart';
import 'package:ecommerce_mobile/model/rezervacijaprostora.dart';
import 'package:ecommerce_mobile/model/search_result.dart';
import 'package:ecommerce_mobile/providers/rezervacijaprostora_provider.dart';
import 'package:ecommerce_mobile/providers/utils.dart';
import 'package:ecommerce_mobile/screens/product_details_screen.dart';
import 'package:ecommerce_mobile/screens/rezervacija_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_mobile/providers/product_provider.dart';

class RezervacijaList extends StatefulWidget {
  const RezervacijaList({super.key});

  @override
  State<RezervacijaList> createState() => _RezervacijaListState();
}

class _RezervacijaListState extends State<RezervacijaList> {
  
  late RezervacijaprostoraProvider rezervacijaProvider;
  TextEditingController imePrezimeController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController radniProstorController = TextEditingController();

  SearchResult<RezervacijaProstora>? data;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  
  }

  @override
  void initState() {
    super.initState();
    rezervacijaProvider = context.read<RezervacijaprostoraProvider>();
    loadData();
  }

  void loadData() async {
    var rezervacijaprostora = await rezervacijaProvider.get();
    this.data = rezervacijaprostora;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var potvrdjena = data?.items?.where((x) => x.status =="Potvrdjena").length??0;
    var nacekanju = data?.items?.where((x) => x.status =="NaCekanju").length??0;
    var otkazana = data?.items?.where((x) => x.status =="Otkazana").length??0;

    return MasterScreen(
      title: "Rezervacija List",
      child: Center(
        child: Column(
          children: [
            _buildSearch(),
            _buildResultView()
            ,
            Padding(padding: EdgeInsets.all(20),
            child: Text("Potvrdjena: $potvrdjena, Na Čekanju: $nacekanju, Otkazana: $otkazana")
            )
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
                controller: imePrezimeController,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Radni Prostor",
                  border: OutlineInputBorder(),
                ),
                controller: radniProstorController,
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

            ElevatedButton(
              onPressed: () async {
                var filter = {
                  "imePrezime": imePrezimeController.text,
                  "RadniProstorId": radniProstorController.text,
                  "Status": statusController.text,
                };
                var rezervacijaprostora = await rezervacijaProvider.get(filter: filter);
                this.data = rezervacijaprostora;
                setState(() {});
              },
              child: Text("Search"),
            ),
            SizedBox(width: 10),
            ElevatedButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewRezervacijaScreen()));
            }, child: Text("New"))
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
          Text(x.rezervacijaProstoraId.toString()),
          Text("${x.korisnik?.firstName} ${x.korisnik?.lastName}"),
          Text(x.radniProstor!.oznaka.toString()),
          Text(x.status.toString()),
        ],
      ),
    )).cast<Widget>().toList();
    
    return list;
  }

}
