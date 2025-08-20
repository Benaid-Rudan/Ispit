import 'package:ecommerce_desktop/layouts/master_screen.dart';
import 'package:ecommerce_desktop/model/product.dart';
import 'package:ecommerce_desktop/model/radni_prostor.dart';
import 'package:ecommerce_desktop/model/rezervacija_prostora.dart';
import 'package:ecommerce_desktop/model/search_result.dart';
import 'package:ecommerce_desktop/providers/radni_prostor_provider.dart';
import 'package:ecommerce_desktop/providers/rezervacija_prostora_provider.dart';
import 'package:ecommerce_desktop/providers/utils.dart';
import 'package:ecommerce_desktop/screens/product_details_screen.dart';
import 'package:ecommerce_desktop/screens/rezervacija_prostora_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_desktop/providers/product_provider.dart';

class RezervacijaProstoraList extends StatefulWidget {
  const RezervacijaProstoraList({super.key});

  @override
  State<RezervacijaProstoraList> createState() => _RezervacijaProstoraListState();
}

class _RezervacijaProstoraListState extends State<RezervacijaProstoraList> {
  // late ProductProvider productProvider;
  late RezervacijaProstoraProvider rezervacijaProstoraProvider;
  late RadniProstorProvider radniProstorProvider;
  // TextEditingController codeController = TextEditingController();
  // TextEditingController searchController = TextEditingController();
  TextEditingController korisnikController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController radniProstorController = TextEditingController();


  // SearchResult<Product>? products;
  SearchResult<RezervacijaProstora>? rezervacija_prostora;
  SearchResult<RadniProstor>? radni_prostori;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // productProvider = context.read<ProductProvider>();
    rezervacijaProstoraProvider = context.read<RezervacijaProstoraProvider>();
    radniProstorProvider = context.read<RadniProstorProvider>();
    _loadData();
  }

  _loadData() async{
    rezervacija_prostora = await rezervacijaProstoraProvider.get(
      filter: {
        "IsKorisnikIncluded": true,
        "IsRadniProstorIncluded": true,
      },
    );
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "RezervacijaProstora List",
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
                  hintText: "Korisnik",
                  border: OutlineInputBorder(),
                ),
                controller: korisnikController,
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
                  "IsKorisnikIncluded": true,
                  "KorisnikId": korisnikController.text,
                  "RadniProstorId": radniProstorController.text,
                  "StatusRezervacije": statusController.text,
                  // "IsRadniProstorIncluded": searchController.text,
                };
                // debugPrint(filter.toString());
                var rezervacija_prostora = await rezervacijaProstoraProvider.get(filter: filter);
                // debugPrint(products.items?.firstOrNull?.name);
                this.rezervacija_prostora = rezervacija_prostora;
                setState(() {});
              },
              child: Text("Search"),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RezervacijaProstoraDetailsScreen(rezervacija_prostora: null)));
              },
              child: Text("New"),
            )
          ],
        ));
  }
  

  Widget _buildResultView() {
    return Expanded(child: Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: DataTable(
        columns: [
          DataColumn(label: Text("Rezervacija ID")),
          DataColumn(label: Text("Korisnik")),
          DataColumn(label: Text("datum Rezervacije")),
          DataColumn(label: Text("trajanje Rezervacije")),
          DataColumn(label: Text("radni Prostor kapacitet")), 
          DataColumn(label: Text("status")),
        ],
        rows: rezervacija_prostora?.items?.map((e) => DataRow(
          onSelectChanged: (value) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => RezervacijaProstoraDetailsScreen(rezervacija_prostora: e)));
          },
          cells: [
            DataCell(Text(e.rezervacijaProstoraId.toString())),
            DataCell(Text(e.korisnik?.firstName ?? "N/A")),
            DataCell(Text(e.datumRezervacije.toString())),
            DataCell(Text(e.trajanje.toString())),
            DataCell(Text(e.radniProstor?.kapacitet.toString() ?? "N/A")),
            DataCell(Text(e.statusRezervacije!)),
          ])).toList() ?? [],
      ),
      ),
    ));
  }

}
