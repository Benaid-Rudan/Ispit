import 'package:ecommerce_mobile/layouts/master_screen.dart';
import 'package:ecommerce_mobile/model/cart_provider.dart';
import 'package:ecommerce_mobile/model/product.dart';
import 'package:ecommerce_mobile/model/search_result.dart';
import 'package:ecommerce_mobile/model/transakcija.dart';
import 'package:ecommerce_mobile/providers/transakcija_provider.dart';
import 'package:ecommerce_mobile/providers/utils.dart';
import 'package:ecommerce_mobile/screens/product_details_screen.dart';
import 'package:ecommerce_mobile/screens/transakcija_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_mobile/providers/product_provider.dart';

class TransakcijaScreen extends StatefulWidget {
  const TransakcijaScreen({super.key});

  @override
  State<TransakcijaScreen> createState() => _TransakcijaScreenState();
}

class _TransakcijaScreenState extends State<TransakcijaScreen> {
  // late ProductProvider productProvider;
  // late CartProvider cartProvider;
  late TransakcijaProvider transakcijaProvider;

  TextEditingController kategorijaTransakcijeController = TextEditingController();
  TextEditingController datumOdController = TextEditingController();
  TextEditingController datumDoController = TextEditingController();

  // SearchResult<Product>? data;
  SearchResult<Transakcija>? transakcijaData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  
  }

  @override
  void initState() {
    super.initState();
    transakcijaProvider = context.read<TransakcijaProvider>();
    // cartProvider = context.read<CartProvider>();
    loadData();
  }

  void loadData() async {
    var transakcija = await transakcijaProvider.get(filter: {
      "IsKategorijaIncluded": true,
    });
    this.transakcijaData = transakcija;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
  var planiran = transakcijaData?.items?.where((x)=>x.statusTransakcije=="Planiran").toList().length ?? 0;
  var zavrsen = transakcijaData?.items?.where((x)=>x.statusTransakcije=="Zavrsen").toList().length ?? 0;
  var otkazan = transakcijaData?.items?.where((x)=>x.statusTransakcije=="Otkazan").toList().length ?? 0;

    return MasterScreen(
      title: "Transakcija List",
      child: Center(
        child: Column(
          children: [
            _buildSearch(),
            _buildResultView(),
            Padding(padding: EdgeInsets.all(16.0),
            child: Text("Broj planiran: $planiran, Broj zavrsen: $zavrsen, Broj otkazan: $otkazan"),)
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
                  hintText: "KategorijaId",
                  border: OutlineInputBorder(),
                ),
                controller: kategorijaTransakcijeController,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "DatumOd",
                  border: OutlineInputBorder(),
                ),
                controller: datumOdController,
              ),
            ),
             SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "DatumDo",
                  border: OutlineInputBorder(),
                ),
                controller: datumDoController,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                var filter = {
                  "IsKategorijaIncluded": true,
                  "KategorijaId": kategorijaTransakcijeController.text,
                  "DatumOd": datumOdController.text,
                  "DatumDo": datumDoController.text,
                };
                debugPrint(filter.toString());
                var transakcija_data = await transakcijaProvider.get(filter: filter);
                // debugPrint(products.items?.firstOrNull?.name);
                this.transakcijaData = transakcija_data;
                setState(() {});
              },
              child: Text("Search"),
            ),
            SizedBox(width: 10),
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => TransakcijaDetailsScreen()
                ),
              );
            },
              child: Text("Add New"),
            )
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
    if (transakcijaData == null || transakcijaData?.items?.length == 0) {
      return [Text("Loading...")];
    }

    List<Widget> list = transakcijaData!.items!.map((x) => Container(
      child: Column(
        children: [
          
          Text(x.kategorijaTransakcije?.naziv ?? ""),
          Text(x.iznos.toString()),
          Text(x.kategorijaTransakcije?.tip ?? ""),
          Text(x.statusTransakcije ?? ""),
          Text(x.datumTransakcije!.toIso8601String()),
        ],
      ),
    )).cast<Widget>().toList();
    
    return list;
  }

}
