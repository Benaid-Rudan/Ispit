import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_mobile/layouts/master_screen.dart';
import 'package:ecommerce_mobile/model/product.dart';
import 'package:ecommerce_mobile/model/product_type.dart';
import 'package:ecommerce_mobile/model/radniprostor.dart';
import 'package:ecommerce_mobile/model/rezervacijaprostora.dart';
import 'package:ecommerce_mobile/model/search_result.dart';
import 'package:ecommerce_mobile/model/unit_of_measure.dart';
import 'package:ecommerce_mobile/providers/product_provider.dart';
import 'package:ecommerce_mobile/providers/product_type_provider.dart';
import 'package:ecommerce_mobile/providers/radniprostor_provider.dart';
import 'package:ecommerce_mobile/providers/rezervacijaprostora_provider.dart';
import 'package:ecommerce_mobile/providers/unit_of_measure_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:file_picker/file_picker.dart';

class NewRezervacijaScreen extends StatefulWidget {
  RezervacijaProstora? rezervacijaProstora;
  NewRezervacijaScreen({super.key, this.rezervacijaProstora});

  @override
  State<NewRezervacijaScreen> createState() => _NewRezervacijaScreenState();
}

class _NewRezervacijaScreenState extends State<NewRezervacijaScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  Map<String, dynamic> _initalValue = {};

  late RezervacijaprostoraProvider rezervacijaProstoraProvider;
  late RadniprostorProvider radniprostorProvider;
  SearchResult<RezervacijaProstora>? rezervacijaProstora;
  SearchResult<RadniProstor>? radniProstor;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    rezervacijaProstoraProvider =
        Provider.of<RezervacijaprostoraProvider>(context, listen: false);
    radniprostorProvider =
        Provider.of<RadniprostorProvider>(context, listen: false);
    _initalValue = {
      "rezervacijaProstoraId": widget.rezervacijaProstora?.rezervacijaProstoraId,
      "korisnikId": widget.rezervacijaProstora?.korisnikId,
      "radniProstorId": widget.rezervacijaProstora?.radniProstorId,
      "datumRezervacije": widget.rezervacijaProstora?.datumRezervacije,
      "trajanje": widget.rezervacijaProstora?.trajanje,
      "status": widget.rezervacijaProstora?.status,
      "napomena": widget.rezervacijaProstora?.napomena
    };
    print("widget.rezervacijaProstora");
    print(_initalValue);

    initFormData();
  }

  initFormData() async {
    rezervacijaProstora = await rezervacijaProstoraProvider.get();
    radniProstor = await radniprostorProvider.get();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Rezervacija Details",
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

          int? trajanje = int.tryParse(request["trajanje"] ?? "");
          if(trajanje! > 6) {
            request["status"] = "Otkazana";
          }
          else {
            request["status"] = "Potvrdjena";
          }

          if (widget.rezervacijaProstora == null) {
            widget.rezervacijaProstora = await rezervacijaProstoraProvider.insert(request);
          } else {
            widget.rezervacijaProstora = await rezervacijaProstoraProvider.update(widget.rezervacijaProstora!.rezervacijaProstoraId!, request);
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
              Row(
                children: [
                  Expanded(
                      child: FormBuilderDropdown(
                    name: "radniProstorId",
                    decoration: InputDecoration(labelText: "Radni Prostor"),
                    items: radniProstor?.items
                            ?.map((e) => DropdownMenuItem(
                                value: e.radniProstorId, child: Text(e.oznaka.toString())))
                            .toList() ??
                        [],
                  )),
                ],
              ),
               FormBuilderTextField(
                name: "trajanje",
                decoration: InputDecoration(labelText: "trajanje"),
              ),
              FormBuilderTextField(
                name: "status",
                decoration: InputDecoration(labelText: "status"),
              ),
              FormBuilderTextField(
                name: "napomena",
                decoration: InputDecoration(labelText: "napomena"),
              ),
              FormBuilderTextField(
                name: "datumRezervacije",
                decoration: InputDecoration(labelText: "datumRezervacije"),
              ),
              
            ],
          ),
        ));
  }
}
