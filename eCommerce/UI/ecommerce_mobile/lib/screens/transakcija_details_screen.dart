import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_mobile/layouts/master_screen.dart';
import 'package:ecommerce_mobile/model/product.dart';
import 'package:ecommerce_mobile/model/product_type.dart';
import 'package:ecommerce_mobile/model/search_result.dart';
import 'package:ecommerce_mobile/model/transakcija.dart';
import 'package:ecommerce_mobile/model/unit_of_measure.dart';
import 'package:ecommerce_mobile/providers/product_provider.dart';
import 'package:ecommerce_mobile/providers/product_type_provider.dart';
import 'package:ecommerce_mobile/providers/transakcija_provider.dart';
import 'package:ecommerce_mobile/providers/unit_of_measure_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:file_picker/file_picker.dart';

class TransakcijaDetailsScreen extends StatefulWidget {
  // Product? product;
  Transakcija? transakcija;

  TransakcijaDetailsScreen({super.key, this.transakcija});

  @override
  State<TransakcijaDetailsScreen> createState() => _TransakcijaDetailsScreenState();
}

class _TransakcijaDetailsScreenState extends State<TransakcijaDetailsScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  Map<String, dynamic> _initalValue = {};

  late ProductProvider productProvider;
  late TransakcijaProvider transakcijaProvider; 
  // late UnitOfMeasureProvider unitOfMeasureProvider;
  // late ProductTypeProvider productTypeProvider;

  SearchResult<UnitOfMeasure>? unitOfMeasures;
  SearchResult<Transakcija>? transakcije;
  // SearchResult<ProductType>? productTypes;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    transakcijaProvider = Provider.of<TransakcijaProvider>(context, listen: false);
    _initalValue = {
      "korisnikId": widget.transakcija?.korisnikId.toString(),
      "iznos": widget.transakcija?.iznos.toString(),
      "datumTransakcije": widget.transakcija?.datumTransakcije?.toIso8601String(),
      "opis": widget.transakcija?.opis,
      "kategorijaTransakcijeId": widget.transakcija?.kategorijaTransakcijeId.toString(),
      "statusTransakcije": widget.transakcija?.statusTransakcije,

    };
    print(_initalValue);

    initFormData();
  }

  initFormData() async {
    transakcije = await transakcijaProvider.get();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Transackije Details",
      child: Column(children: [
        _buildForm(),
        _buildSaveButton()
      ],),
    );
  }

  Widget _buildSaveButton() {
  return ElevatedButton(
    onPressed: () async {
      try {
        formKey.currentState?.saveAndValidate();
        if (formKey.currentState?.validate() ?? false) {
          print(formKey.currentState?.value.toString());
          var request = Map.from(formKey.currentState?.value ?? {});

          if (widget.transakcija == null) {
            widget.transakcija = await transakcijaProvider.insert(request);
          } else {
            widget.transakcija = await transakcijaProvider.update(
              widget.transakcija!.transakcijaId!, 
              request
            );
          }

          // ako je sve proslo, prikazi uspjeh
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Transakcija uspješno sačuvana")),
          );
        }
      } catch (e) {
        // ako je backend bacio exception, prikazi ga
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
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
                inputType: InputType.date,
                decoration: InputDecoration(labelText: "datumTransakcije"),
                valueTransformer: ((val)=>val?.toIso8601String()),
              ),
              FormBuilderTextField(
                name: "opis",
                decoration: InputDecoration(labelText: "opis"),
              ),
              FormBuilderTextField(
                name: "kategorijaTransakcijeId",
                decoration: InputDecoration(labelText: "kategorijaTransakcijeId"),
              ),
              FormBuilderTextField(
                name: "statusTransakcije",
                decoration: InputDecoration(labelText: "statusTransakcije"),
              ),  

            ],
          ),
        ));
  }
}
