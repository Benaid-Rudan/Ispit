import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_mobile/layouts/master_screen.dart';
import 'package:ecommerce_mobile/model/product.dart';
import 'package:ecommerce_mobile/model/product_type.dart';
import 'package:ecommerce_mobile/model/rezervacija_prostora.dart';
import 'package:ecommerce_mobile/model/search_result.dart';
import 'package:ecommerce_mobile/model/unit_of_measure.dart';
import 'package:ecommerce_mobile/providers/product_provider.dart';
import 'package:ecommerce_mobile/providers/product_type_provider.dart';
import 'package:ecommerce_mobile/providers/rezervacija_prostora_provider.dart';
import 'package:ecommerce_mobile/providers/unit_of_measure_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:file_picker/file_picker.dart';

class RezervacijaDetailsScreen extends StatefulWidget {
  RezervacijaProstora? rezervacijaProstora;
  RezervacijaDetailsScreen({super.key, this.rezervacijaProstora});

  @override
  State<RezervacijaDetailsScreen> createState() => _RezervacijaDetailsScreenState();
}

class _RezervacijaDetailsScreenState extends State<RezervacijaDetailsScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  Map<String, dynamic> _initalValue = {};

  // late ProductProvider productProvider;
  // late UnitOfMeasureProvider unitOfMeasureProvider;
  // late ProductTypeProvider productTypeProvider;
  late RezervacijaProstoraProvider rezervacijaProstoraProvider;

  // SearchResult<UnitOfMeasure>? unitOfMeasures;
  // SearchResult<ProductType>? productTypes;
  SearchResult<RezervacijaProstora>? rezervacijaSearchResult;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    rezervacijaProstoraProvider = Provider.of<RezervacijaProstoraProvider>(context, listen: false);
    // unitOfMeasureProvider =
    //     Provider.of<UnitOfMeasureProvider>(context, listen: false);
    // productTypeProvider =
    //     Provider.of<ProductTypeProvider>(context, listen: false);

    _initalValue = {
      "radniProstorId": widget.rezervacijaProstora?.radniProstorId.toString(),
      "korisnikId": widget.rezervacijaProstora?.korisnikId.toString(),
      "datumEvidencije": widget.rezervacijaProstora?.datumEvidencije?.toIso8601String(),
      "trajanje": widget.rezervacijaProstora?.trajanje.toString(),
      "statusRezervacije": widget.rezervacijaProstora?.statusRezervacije,
      "napomena": widget.rezervacijaProstora?.napomena,

    };
    // print("widget.product");
    print(_initalValue);

    initFormData();
  }

  initFormData() async {
    rezervacijaSearchResult = await rezervacijaProstoraProvider.get(filter: { 
      "IsKorisnikIncluded": true,
      "IsRadniProstorIncluded": true,
    });
    // productTypes = await productTypeProvider.get();

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

           // Provjeri trajanje i postavi status prema novoj logici
          int? trajanje = int.tryParse(request['trajanje']?.toString() ?? '0');
          
          if (trajanje != null) {
            if (trajanje > 6) {
              // Ako je trajanje veće od 6 sati, status je "Aktivna"
              request['statusRezervacije'] = "Aktivna";
            } else {
              // Ako je trajanje 6 sati ili manje, status je "Potvrdjena"
              request['statusRezervacije'] = request['statusRezervacije'].toString();
            }
          }

          print(request.toString());

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
              FormBuilderTextField(
                name: "statusRezervacije",
                decoration: InputDecoration(labelText: "statusRezervacije"),
              ),
              // FormBuilderTextField(
              //   name: "radniProstorId",
              //   decoration: InputDecoration(labelText: "radniProstorId"),
              // ),
              FormBuilderDropdown(name: "radniProstorId",
              items: rezervacijaSearchResult?.items
              ?.map((e)=>e.radniProstorId?.toString())
              .where((val)=>val != null)
              .toSet()
              .map((val)=>DropdownMenuItem(value:val, child: Text(val!),))
              .toList() ?? [],
              decoration: InputDecoration(labelText: "radniProstorId"),
              ),
              FormBuilderDateTimePicker(
                name: "datumEvidencije",
                inputType: InputType.date,
                decoration: InputDecoration(labelText: "datumEvidencije"),
                valueTransformer: (val)=>val?.toIso8601String(),
              ),
              FormBuilderTextField(
                name: "trajanje",
                decoration: InputDecoration(labelText: "trajanje"),
              ),
              FormBuilderTextField(
                name: "napomena",
                decoration: InputDecoration(labelText: "napomena"),
              ),
             
            ],
          ),
        ));
  }
}
