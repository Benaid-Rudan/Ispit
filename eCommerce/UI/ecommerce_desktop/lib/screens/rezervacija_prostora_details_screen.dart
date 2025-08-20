import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_desktop/layouts/master_screen.dart';
import 'package:ecommerce_desktop/model/product.dart';
import 'package:ecommerce_desktop/model/product_type.dart';
import 'package:ecommerce_desktop/model/radni_prostor.dart';
import 'package:ecommerce_desktop/model/rezervacija_prostora.dart';
import 'package:ecommerce_desktop/model/search_result.dart';
import 'package:ecommerce_desktop/model/unit_of_measure.dart';
import 'package:ecommerce_desktop/providers/product_provider.dart';
import 'package:ecommerce_desktop/providers/product_type_provider.dart';
import 'package:ecommerce_desktop/providers/radni_prostor_provider.dart';
import 'package:ecommerce_desktop/providers/rezervacija_prostora_provider.dart';
import 'package:ecommerce_desktop/providers/unit_of_measure_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:file_picker/file_picker.dart';

class RezervacijaProstoraDetailsScreen extends StatefulWidget {
  // Product? product;
  RezervacijaProstora? rezervacija_prostora;
  RadniProstor? radni_prostor;
  RezervacijaProstoraDetailsScreen({super.key, this.rezervacija_prostora});

  @override
  State<RezervacijaProstoraDetailsScreen> createState() => _RezervacijaProstoraDetailsScreenState();
}

class _RezervacijaProstoraDetailsScreenState extends State<RezervacijaProstoraDetailsScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  Map<String, dynamic> _initalValue = {};

  // late ProductProvider productProvider;
  // late UnitOfMeasureProvider unitOfMeasureProvider;
  // late ProductTypeProvider productTypeProvider;
  late RezervacijaProstoraProvider rezervacijaProstoraProvider;
  late RadniProstorProvider radniProstorProvider;

  // SearchResult<UnitOfMeasure>? unitOfMeasures;
  // SearchResult<ProductType>? productTypes;
  SearchResult<RadniProstor>? radniProstori;
  SearchResult<RezervacijaProstora>? rezervacijaProstori;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    rezervacijaProstoraProvider = Provider.of<RezervacijaProstoraProvider>(context, listen: false);
    radniProstorProvider = Provider.of<RadniProstorProvider>(context, listen: false);

    _initalValue = {
      "rezervacijaProstoraId": widget.rezervacija_prostora?.rezervacijaProstoraId.toString(),
      "korisnikId": widget.rezervacija_prostora?.korisnikId.toString(),
      "radniProstorId": widget.rezervacija_prostora?.radniProstorId?.toString(),
      "datumRezervacije": widget.rezervacija_prostora!.datumRezervacije?.toIso8601String(),
      "trajanje": widget.rezervacija_prostora?.trajanje.toString(),
      "statusRezervacije": widget.rezervacija_prostora?.statusRezervacije,
      "napomena": widget.rezervacija_prostora?.napomena

    };
    print(_initalValue);

    initFormData();
  }

  initFormData() async {
    rezervacijaProstori = await rezervacijaProstoraProvider.get();
    radniProstori = await radniProstorProvider.get();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "RezervacijaProstora Details",
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
          if (widget.rezervacija_prostora == null) {
            widget.rezervacija_prostora = await rezervacijaProstoraProvider.insert(request);
          } else {
            widget.rezervacija_prostora = await rezervacijaProstoraProvider.update(widget.rezervacija_prostora!.rezervacijaProstoraId!, request);
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
                name: "trajanje",
                decoration: InputDecoration(labelText: "trajanje"),
              ),
              Row(
                children: [
                  Expanded(
                      child: FormBuilderDropdown(
                    name: "radniProstorId",
                    decoration: InputDecoration(labelText: "radniProstor"),
                    items: radniProstori?.items
                            ?.map((e) => DropdownMenuItem(
                                value: e.radniProstorId, child: Text(e.oznaka.toString())))
                            .toList() ??
                        [],
                  )),
                  Expanded(
                      child: FormBuilderDateTimePicker(name:  "datumRezervacije",
                        inputType: InputType.date,
                        decoration: InputDecoration(labelText: "datumRezervacije"),
                        initialValue: widget.rezervacija_prostora?.datumRezervacije ?? DateTime.now(),
                      )),
                ],
              ),
              FormBuilderTextField(
                name: "napomena",
                decoration: InputDecoration(labelText: "napomena"),
              ),
              FormBuilderTextField(
                name: "statusRezervacije",
                decoration: InputDecoration(labelText: "statusRezervacije"),
              ),
              
            ],
          ),
        ));
  }
}
