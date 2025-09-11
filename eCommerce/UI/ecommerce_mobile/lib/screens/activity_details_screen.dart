import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_mobile/layouts/master_screen.dart';
import 'package:ecommerce_mobile/model/activity.dart';
import 'package:ecommerce_mobile/model/product.dart';
import 'package:ecommerce_mobile/model/product_type.dart';
import 'package:ecommerce_mobile/model/search_result.dart';
import 'package:ecommerce_mobile/model/unit_of_measure.dart';
import 'package:ecommerce_mobile/model/user.dart';
import 'package:ecommerce_mobile/model/useractivity.dart';
import 'package:ecommerce_mobile/providers/activity_provider.dart';
import 'package:ecommerce_mobile/providers/product_provider.dart';
import 'package:ecommerce_mobile/providers/product_type_provider.dart';
import 'package:ecommerce_mobile/providers/unit_of_measure_provider.dart';
import 'package:ecommerce_mobile/providers/user_provider.dart';
import 'package:ecommerce_mobile/providers/useractivity_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:file_picker/file_picker.dart';

class ActivityDetailsScreen extends StatefulWidget {
  UserActivity? activity;
  ActivityDetailsScreen({super.key, this.activity});

  @override
  State<ActivityDetailsScreen> createState() => _ActivityDetailsScreenState();
}

class _ActivityDetailsScreenState extends State<ActivityDetailsScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  Map<String, dynamic> _initalValue = {};

  late UseractivityProvider activityProvider;
  // late UserProvider userProvider;
  // late ActivityProvider activityTypeProvider;

  SearchResult<UserActivity>? activity;
  // SearchResult<User>? users;
  // SearchResult<Activity>? activities;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    activityProvider = Provider.of<UseractivityProvider>(context, listen: false);
    // userProvider = Provider.of<UserProvider>(context, listen: false);
    // activityTypeProvider = Provider.of<ActivityProvider>(context, listen: false);
    _initalValue = {
      "korisnikId": widget.activity?.korisnikId.toString(),
      "activityId": widget.activity?.activityId.toString(),
      "dateAssigned": widget.activity?.dateAssigned?.toIso8601String(),
      "statusActivity": widget.activity?.statusActivity,
      "note": widget.activity?.note,
      "completedAt": widget.activity?.completedAt?.toIso8601String(),
    };
    print(_initalValue);

    initFormData();
  }

  initFormData() async {
    activity = await activityProvider.get();
    // users = await userProvider.get();
    // activities = await activityTypeProvider.get();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Activity Details",
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
          if (widget.activity == null) {
            widget.activity = await activityProvider.insert(request);
          } else {
            widget.activity = await activityProvider.update(widget.activity!.activityId!, request);
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
                    items: activity?.items
                            ?.map((e) => DropdownMenuItem(
                                value: e.korisnikId, child: Text(e.korisnik!.firstName!.toString())))
                            .toList() ??
                        [],
                  )),
                  Expanded(
                      child: FormBuilderDropdown(
                    name: "activityId",
                    decoration: InputDecoration(labelText: "Activity Type"),
                    items: activity?.items
                            ?.map((e) => DropdownMenuItem(
                                value: e.activityId, child: Text(e.activity!.name!.toString())))
                            .toList() ??
                        [],
                  ))
                ],
              ),
              FormBuilderDateTimePicker(name:"dateAssigned", 
              decoration: InputDecoration(labelText: "Date Assigned"),
              inputType: InputType.date,
              valueTransformer: (value) => value?.toIso8601String(),
              ),

              FormBuilderTextField(
                name: "statusActivity",
                decoration: InputDecoration(labelText: "Status Activity"),
              ),
              FormBuilderTextField(
                name: "note",
                decoration: InputDecoration(labelText: "Note"),
              ),
              FormBuilderTextField(
                name: "completedAt",
                decoration: InputDecoration(labelText: "CompletedAt"),
              ),
              
            ],
          ),
        ));
  }
}
