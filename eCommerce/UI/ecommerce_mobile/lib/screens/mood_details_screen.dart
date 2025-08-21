import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_mobile/layouts/master_screen.dart';
import 'package:ecommerce_mobile/model/mood.dart';
import 'package:ecommerce_mobile/model/product.dart';
import 'package:ecommerce_mobile/model/product_type.dart';
import 'package:ecommerce_mobile/model/search_result.dart';
import 'package:ecommerce_mobile/model/unit_of_measure.dart';
import 'package:ecommerce_mobile/model/user.dart';
import 'package:ecommerce_mobile/providers/mood_provider.dart';
import 'package:ecommerce_mobile/providers/product_provider.dart';
import 'package:ecommerce_mobile/providers/product_type_provider.dart';
import 'package:ecommerce_mobile/providers/unit_of_measure_provider.dart';
import 'package:ecommerce_mobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:file_picker/file_picker.dart';

class MoodDetailsScreen extends StatefulWidget {
  // Product? product;
  Mood? mood;
  MoodDetailsScreen({super.key, this.mood});

  @override
  State<MoodDetailsScreen> createState() => _MoodDetailsScreenState();
}

class _MoodDetailsScreenState extends State<MoodDetailsScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  Map<String, dynamic> _initalValue = {};

  // late ProductProvider productProvider;
  // late UnitOfMeasureProvider unitOfMeasureProvider;
  // late ProductTypeProvider productTypeProvider;
  late MoodProvider moodProvider;
  late UserProvider korisnikProvider;
  // SearchResult<UnitOfMeasure>? unitOfMeasures;
  // SearchResult<ProductType>? productTypes;
  SearchResult<Mood>? moodSearchResult;
  SearchResult<User>? korisnikSearchResult;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    moodProvider = Provider.of<MoodProvider>(context, listen: false);
    korisnikProvider = Provider.of<UserProvider>(context, listen: false);
    _initalValue = {
      "korisnikId": widget.mood?.korisnikId,
      "statusRaspolozenja": widget.mood?.statusRaspolozenja,
      "opis": widget.mood?.opis,
      "datumEvidencije": widget.mood?.datumEvidencije?.toIso8601String(),
    };
    print("widget.mood");
    print(_initalValue);

    initFormData();
  }

  initFormData() async {
  try {
    moodSearchResult = await moodProvider.get();
    print("Mood loaded: ${moodSearchResult?.items?.length}");
    
    korisnikSearchResult = await korisnikProvider.get();
    print("Users loaded: ${korisnikSearchResult?.items?.length}");
  } catch(e) {
    print("Error loading data: $e");
  }

  setState(() {
    isLoading = false;
  });
}


  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Mood Details",
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
          if (widget.mood == null) {
            widget.mood = await moodProvider.insert(request);
          } else {
            widget.mood = await moodProvider.update(widget.mood!.moodId!, request);
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
              Row(
                children: [
                  Expanded(
                     child: FormBuilderDropdown(
                      name: "korisnikId",
                      decoration: InputDecoration(labelText: "Korisnik"),
                      items: moodSearchResult?.items
                          ?.map((e)=>e.korisnikId?.toString())
                          .where((val)=> val != null)
                          .toSet()
                          .map((val)=> DropdownMenuItem(
                            value: val,
                            child: Text(val ?? ""),
                          )).toList() ?? [],
                    )),
                ],
              ),
              FormBuilderTextField(
                name: "statusRaspolozenja",
                decoration: InputDecoration(labelText: "statusRaspolozenja"),
              ),
              FormBuilderTextField(
                name: "opis",
                decoration: InputDecoration(labelText: "opis"),),
              FormBuilderDateTimePicker(name: "datumEvidencije",
                inputType: InputType.date,
                decoration: InputDecoration(labelText: "Datum Evidencije"),
                valueTransformer: (value) => value?.toIso8601String(),
              ),
              
            ],
          ),
        ));
  }
}
