import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_mobile/layouts/master_screen.dart';
import 'package:ecommerce_mobile/model/limit.dart';
import 'package:ecommerce_mobile/model/product.dart';
import 'package:ecommerce_mobile/model/product_type.dart';
import 'package:ecommerce_mobile/model/search_result.dart';
import 'package:ecommerce_mobile/model/transakcija.dart';
import 'package:ecommerce_mobile/model/unit_of_measure.dart';
import 'package:ecommerce_mobile/providers/limit_provider.dart';
import 'package:ecommerce_mobile/providers/product_provider.dart';
import 'package:ecommerce_mobile/providers/product_type_provider.dart';
import 'package:ecommerce_mobile/providers/transakcija_provider.dart';
import 'package:ecommerce_mobile/providers/unit_of_measure_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:file_picker/file_picker.dart';

class NewTransakcijaScreen extends StatefulWidget {
  Transakcija? transakcija;
  NewTransakcijaScreen({super.key, this.transakcija});

  @override
  State<NewTransakcijaScreen> createState() => _NewTransakcijaScreenState();
}

class _NewTransakcijaScreenState extends State<NewTransakcijaScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  Map<String, dynamic> _initalValue = {};

  
  late TransakcijaProvider transakcijaProvider;
  late LimitProvider limitProvider;

  SearchResult<Transakcija>? transakcija;
  SearchResult<Limit>? limitResult;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    transakcijaProvider = Provider.of<TransakcijaProvider>(context, listen: false);
    limitProvider = Provider.of<LimitProvider>(context, listen: false);

    _initalValue = {
      "korisnikId": widget.transakcija?.korisnikId.toString(),
      "iznos": widget.transakcija?.iznos.toString(),
      "datumTransakcije": widget.transakcija?.datumTransakcije?.toIso8601String(),
      "opis": widget.transakcija?.opis,
      "kategorijaTransakcijeId": widget.transakcija?.kategorijaTransakcijeId.toString(),
      "status": widget.transakcija?.status,
    };
    print("widget.transakcija");
    print(_initalValue);

    initFormData();
  }

  initFormData() async {
    transakcija = await transakcijaProvider.get();
    limitResult = await limitProvider.get();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Transakcija Details",
      child: Column(children: [
        _buildForm(),
        _buildSaveButton()
      ],),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () async {
        formKey.currentState?.saveAndValidate();
        if (formKey.currentState?.validate() ?? false) {
          print(formKey.currentState?.value.toString());
          var request = Map.from(formKey.currentState?.value ?? {});
          final korisnikId = request["korisnikId"];
          final iznos = int.tryParse(request["iznos"].toString()) ?? 0;
          final kategorijaId = request["kategorijaTransakcijeId"];
            // Pronađi limit za izabranu kategoriju transakcije
            final limit = limitResult?.items?.firstWhere( (l) => l.kategorijaTransakcijeId?.toString() == kategorijaId.toString(),)?.iznos;
            if (limit == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Limit nije postavljen za ovu kategoriju!")),
            );
            return;
            }

          // 2. Dohvati sve transakcije za taj mjesec, korisnika i kategoriju
          final now = DateTime.now();
          final transResult = await transakcijaProvider.get(filter: {
            "KorisnikId": korisnikId.toString(),
            "KategorijaTransakcijeId": kategorijaId.toString(),
            "Mjesec": now.month.toString(),
            "Godina": now.year.toString(),
          });
          int ukupno = 0;
          if (transResult.items != null) {
            for (var t in transResult.items!) {
              ukupno += t.iznos ?? 0;
            }
          }
          if (ukupno + iznos > limit) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Prelazite limit od $limit KM. Trenutno: $ukupno KM.")),
            );
            return;
          }

          if (widget.transakcija == null) {
            widget.transakcija = await transakcijaProvider.insert(request);
          } else {
            widget.transakcija = await transakcijaProvider.update(widget.transakcija!.transakcijaId!, request);
          }
        }
      },
      child: Text("Save"),
    );
  }
  
  File? _image;
  String? _base64Image;

  Widget _buildForm() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return FormBuilder(
        key: formKey,
        initialValue: _initalValue,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              FormBuilderTextField(
                name: "korisnikId",
                decoration: InputDecoration(labelText: "korisnikId"),
              ),
              FormBuilderTextField(
                name: "iznos",
                decoration: InputDecoration(labelText: "iznos"),
              ),
              
              FormBuilderDateTimePicker(
                name: "datumTransakcije",
                decoration: InputDecoration(labelText: "Datum Transakcije"),
                inputType: InputType.date,
                valueTransformer: (value)=>value?.toIso8601String(),
              ),
               FormBuilderTextField(
                name: "opis",
                decoration: InputDecoration(labelText: "Opis"),
              ),
               FormBuilderTextField(
                name: "kategorijaTransakcijeId",
                decoration: InputDecoration(labelText: "kategorijaTransakcijeId"),
              ),
              FormBuilderTextField(
                name: "status",
                decoration: InputDecoration(labelText: "status"),
              ),
            ],
          ),
        ));
  }
}
