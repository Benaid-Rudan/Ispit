import 'package:ecommerce_mobile/layouts/master_screen.dart';
import 'package:ecommerce_mobile/model/cart_provider.dart';
import 'package:ecommerce_mobile/model/product.dart';
import 'package:ecommerce_mobile/model/rezervacija_prostora.dart';
import 'package:ecommerce_mobile/model/search_result.dart';
import 'package:ecommerce_mobile/providers/rezervacija_prostora_provider.dart';
import 'package:ecommerce_mobile/providers/utils.dart';
import 'package:ecommerce_mobile/screens/product_details_screen.dart';
import 'package:ecommerce_mobile/screens/rezervacija_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_mobile/providers/product_provider.dart';

class RezervacijaList extends StatefulWidget {
  const RezervacijaList({super.key});

  @override
  State<RezervacijaList> createState() => _RezervacijaListState();
}

class _RezervacijaListState extends State<RezervacijaList> {
  // late ProductProvider productProvider;
  // late CartProvider cartProvider;
  late RezervacijaProstoraProvider rezervacijaProstoraProvider;


  TextEditingController korisnikController = TextEditingController();
  TextEditingController radniProstorController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  // SearchResult<Product>? data;
  SearchResult<RezervacijaProstora>? rezervacijaProstoraData;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  
  }

  @override
  void initState() {
    super.initState();
    rezervacijaProstoraProvider = context.read<RezervacijaProstoraProvider>();
    // cartProvider = context.read<CartProvider>();
    loadData();
  }

  void loadData() async {
    var rezervacija_prostora = await rezervacijaProstoraProvider.get(filter: {
      "IsKorisnikIncluded": true,
      "IsRadniProstorIncluded": true,
      // "KorisnikId": korisnikController.text,
      // "RadniProstorId": radniProstorController.text,  
      // "StatusRezervacije": statusController.text,
    });
    this.rezervacijaProstoraData = rezervacija_prostora;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var otkazana = rezervacijaProstoraData?.items?.where((e)=>e.statusRezervacije == "Otkazana").length ?? 0;
    var aktivna = rezervacijaProstoraData?.items?.where((e)=>e.statusRezervacije == "Aktivna").length ?? 0 ;
    var potvrdjena = rezervacijaProstoraData?.items?.where((e)=>e.statusRezervacije == "Potvrdjena").length ?? 0 ;

    return MasterScreen(
      title: "RezervacijaProstora List",
      child: Center(
        child: Column(
          children: [
            _buildSearch(),
            _buildResultView(),
            Padding(padding:  EdgeInsets.all(16.0),
            child: Text("Broj otkazanih: $otkazana, Broj aktivna: $aktivna, Broj potvrdjena: $potvrdjena"),)
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
                  hintText: "Radni prostor",
                  border: OutlineInputBorder(),
                ),
                controller: radniProstorController,
              ),
            ),
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
                  "IsKorisnikIncluded": true,
                  "IsRadniProstorIncluded": true,
                  "KorisnikId": korisnikController.text,
                  "RadniProstorId": radniProstorController.text,  
                  "StatusRezervacije": statusController.text,
                };
                debugPrint(filter.toString());
                var rezervacija_prostora = await rezervacijaProstoraProvider.get(filter: filter);
                // debugPrint(rezervacija_prostora.items?.firstOrNull?.name);
                this.rezervacijaProstoraData = rezervacija_prostora;
                setState(() {});
              },
              child: Text("Search"),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RezervacijaDetailsScreen()));
              },
              child: Text("New"),
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
  if (rezervacijaProstoraData == null || rezervacijaProstoraData?.items?.length == 0) {
    return [Text("Loading...")];
  }



  List<Widget> list = rezervacijaProstoraData!.items!.map((x) => Container(
    padding: EdgeInsets.all(8),
    margin: EdgeInsets.all(8),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Ime: ", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(x.korisnik?.firstName ?? ""),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Text("Kapacitet: ", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(x.radniProstor?.kapacitet.toString() ?? ""),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Text("Datum: ", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(x.datumEvidencije != null 
                ? DateFormat('dd.MM.yyyy').format(x.datumEvidencije!) 
                : ""),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Text("Trajanje: ", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(x.trajanje.toString()),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Text("Status: ", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(x.statusRezervacije!),
          ],
        ),
      ],
    ),
  )).cast<Widget>().toList();
  
  return list;
}

}
