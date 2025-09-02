import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_mobile/layouts/master_screen.dart';
import 'package:ecommerce_mobile/model/peer_challenge.dart';
import 'package:ecommerce_mobile/model/product_type.dart';
import 'package:ecommerce_mobile/model/search_result.dart';
import 'package:ecommerce_mobile/model/unit_of_measure.dart';
import 'package:ecommerce_mobile/model/user.dart';
import 'package:ecommerce_mobile/providers/peer_challenge_provider.dart';
import 'package:ecommerce_mobile/providers/product_provider.dart';
import 'package:ecommerce_mobile/providers/product_type_provider.dart';
import 'package:ecommerce_mobile/providers/unit_of_measure_provider.dart';
import 'package:ecommerce_mobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:file_picker/file_picker.dart';

class ChallengeDetailsScreen extends StatefulWidget {
  PeerChallenge? peerChallenge;
  ChallengeDetailsScreen({super.key, this.peerChallenge});

  @override
  State<ChallengeDetailsScreen> createState() => _ChallengeDetailsScreenState();
}

class _ChallengeDetailsScreenState extends State<ChallengeDetailsScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  Map<String, dynamic> _initalValue = {};

  late PeerChallengeProvider peerChallengeProvider;
  late UserProvider userProvider;
  SearchResult<PeerChallenge>? peerChallenges;

  bool isLoading = true;

  @override
  void initState()  {
    super.initState();
    peerChallengeProvider = Provider.of<PeerChallengeProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    initFormData();

  }

  initFormData() async {
     peerChallenges = await peerChallengeProvider.get();

     var currentUser = await userProvider.getCurrent();
    var currentUserId = currentUser.id;
    _initalValue = {
     "izazivacId": currentUserId,
     "izazvaniId": widget.peerChallenge?.izazvaniId,
     "challengeId": widget.peerChallenge?.challengeId,
     "statusPeera": widget.peerChallenge?.statusPeera,
     "datumKreiranja": widget.peerChallenge?.datumKreiranja,
    };
    
    print("widget.peerChallenge");
    print(_initalValue);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Challenge Details",
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

          request["izazivacId"]=_initalValue["izazivacId"];
          if(request["datumKreiranja"] is DateTime){
            request["datumKreiranja"] = (request["datumKreiranja"] as DateTime).toIso8601String();
          }
         if (widget.peerChallenge == null) {
           widget.peerChallenge = await peerChallengeProvider.insert(request);
         } else {
           widget.peerChallenge = await peerChallengeProvider.update(widget.peerChallenge!.peerChallengeId!, request);
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
              FormBuilderTextField(
                name: "challengeId",
                decoration: InputDecoration(labelText: "Challenge ID"),
              ),
              FormBuilderDateTimePicker(
                name: "datumKreiranja",
                decoration: InputDecoration(labelText: "Datum Kreiranja"),
                inputType: InputType.date,
                valueTransformer: (val)=>val?.toIso8601String(),
              ),
              FormBuilderTextField(
                name: "statusPeera",
                decoration: InputDecoration(labelText: "Status Peera"),
              ),
              Row(
                children: [
                   Expanded(
                       child: FormBuilderDropdown(
                     name: "izazvaniId",
                     decoration: InputDecoration(labelText: "izazvaniId"),
                     items: peerChallenges?.items
                          ?.map((e)=>e.izazvaniId?.toString())
                          .where((val)=> val != null)
                          .toSet()
                          .map((val)=> DropdownMenuItem(
                            value: val,
                            child: Text(val ?? ""),
                          )).toList() ?? [],
                   )),
                  
                ],
              ),
              
              
            ],
          ),
        ));
  }
}