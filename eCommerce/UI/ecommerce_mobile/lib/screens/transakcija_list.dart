import 'package:ecommerce_mobile/layouts/master_screen.dart';
import 'package:ecommerce_mobile/model/cart_provider.dart';
import 'package:ecommerce_mobile/model/product.dart';
import 'package:ecommerce_mobile/model/search_result.dart';
import 'package:ecommerce_mobile/model/transakcija.dart';
import 'package:ecommerce_mobile/providers/transakcija_provider.dart';
import 'package:ecommerce_mobile/providers/utils.dart';
import 'package:ecommerce_mobile/screens/new_transakcija_screen.dart';
import 'package:ecommerce_mobile/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_mobile/providers/product_provider.dart';

class TransakcijaList extends StatefulWidget {
  const TransakcijaList({super.key});

  @override
  State<TransakcijaList> createState() => _TransakcijaListState();
}

class _TransakcijaListState extends State<TransakcijaList> {
  // late ProductProvider productProvider;
  // late CartProvider cartProvider;
  late TransakcijaProvider transakcijaProvider;
  TextEditingController datumOdController = TextEditingController();
  TextEditingController datumDoController = TextEditingController();
  TextEditingController kategorijaTransakcijeController = TextEditingController();

  SearchResult<Transakcija>? data;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  
  }

  @override
  void initState() {
    super.initState();
    transakcijaProvider = context.read<TransakcijaProvider>();
    loadData();
  }

  void loadData() async {
    var products = await transakcijaProvider.get();
    this.data = products;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var kategorija1 = data?.items?.where((x)=>x.kategorijaTransakcijeId==1).length ?? 0;
    var kategorija2 = data?.items?.where((x)=>x.kategorijaTransakcijeId==2).length ?? 0;

    return MasterScreen(
      title: "Transakcija List",
      child: Center(
        child: Column(
          children: [
            _buildSearch(),
            _buildResultView(),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                  "Kategorija1 broj transakcija: $kategorija1 || kategorija2 broj transakcija: $kategorija2"),
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
                  hintText: "kategorija transakcije id",
                  border: OutlineInputBorder(),
                ),
                controller: kategorijaTransakcijeController,
              ),
            ),
            SizedBox(width: 10),

            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Datum od",
                  border: OutlineInputBorder(),
                ),
                controller: datumOdController,
              ),
            ),
            SizedBox(width: 10),

            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "datum do",
                  border: OutlineInputBorder(),
                ),
                controller: datumDoController,
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () async {
                var filter = {
                  "DatumDo": datumDoController.text,
                  "DatumOd": datumOdController.text,
                  "KategorijaTransakcijeId": kategorijaTransakcijeController.text,
                };
                var products = await transakcijaProvider.get(filter: filter);
                this.data = products;
                setState(() {});
              },
              child: Text("Search"),
            ),
            SizedBox(width: 10),

            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewTransakcijaScreen()));
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
          Text(x.kategorijaTransakcije?.naziv ?? ""),
          Text(x.iznos.toString()),
          Text(x.kategorijaTransakcije!.tip.toString()),
          Text(x.status.toString()),
          Text(x.datumTransakcije.toString()),
        ],
      ),
    )).cast<Widget>().toList();
    
    return list;
  }

}
