import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_mobile/layouts/master_screen.dart';
import 'package:ecommerce_mobile/model/mood.dart';
import 'package:ecommerce_mobile/model/product.dart';
import 'package:ecommerce_mobile/model/product_type.dart';
import 'package:ecommerce_mobile/model/search_result.dart';
import 'package:ecommerce_mobile/model/unit_of_measure.dart';
import 'package:ecommerce_mobile/providers/mood_provider.dart';
import 'package:ecommerce_mobile/providers/product_provider.dart';
import 'package:ecommerce_mobile/providers/product_type_provider.dart';
import 'package:ecommerce_mobile/providers/unit_of_measure_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:file_picker/file_picker.dart';

class MoodInsert extends StatefulWidget {
  Mood? mood;
  MoodInsert({super.key, this.mood});

  @override
  State<MoodInsert> createState() => _MoodInsertState();
}

class _MoodInsertState extends State<MoodInsert> {
  final formKey = GlobalKey<FormBuilderState>();

  Map<String, dynamic> _initalValue = {};

  late MoodProvider moodProvider;

  SearchResult<Mood>? moods;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    moodProvider = Provider.of<MoodProvider>(context, listen: false);

    _initalValue = {
      "korisnikId": widget.mood?.korisnikId.toString(),
      "datumEvidencije": widget.mood?.datumEvidencije?.toIso8601String(),
      "opis": widget.mood?.opis,
      "status": widget.mood?.status,
    };
    print("widget.mood");
    print(_initalValue);

    initFormData();
  }

  initFormData() async {
    moods = await moodProvider.get();

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
                    items: moods?.items
                            ?.map((x)=>x.korisnikId.toString())
                            .where((val)=> val!=null)
                            .toSet()
                            .map((val)=> DropdownMenuItem(
                              value: val,
                              child:  Text(val ?? ""),
                            ))
                            .toList() ??
                        [],
                  )),
                ],
              ),
              FormBuilderDateTimePicker(
                name: "datumEvidencije",
                decoration: InputDecoration(labelText: "Datum Evidencije"),
                inputType: InputType.date,
                valueTransformer: (value) => value?.toIso8601String(),
              ),
              FormBuilderTextField(
                name: "status",
                decoration: InputDecoration(labelText: "Status"),
              ),
              FormBuilderTextField(
                name: "opis",
                decoration: InputDecoration(labelText: "Opis"),
              ),
              
            ],
          ),
        ));
  }
}
