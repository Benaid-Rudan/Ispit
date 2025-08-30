import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_mobile/layouts/master_screen.dart';
import 'package:ecommerce_mobile/model/peer_challenge.dart';
import 'package:ecommerce_mobile/model/product.dart';
import 'package:ecommerce_mobile/model/product_type.dart';
import 'package:ecommerce_mobile/model/search_result.dart';
import 'package:ecommerce_mobile/model/unit_of_measure.dart';
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

class ChallengeDetails2Screen extends StatefulWidget {
  PeerChallenge? challenge;
  ChallengeDetails2Screen({super.key, this.challenge});

  @override
  State<ChallengeDetails2Screen> createState() => _ChallengeDetails2ScreenState();
}

class _ChallengeDetails2ScreenState extends State<ChallengeDetails2Screen> {
  final formKey = GlobalKey<FormBuilderState>();

  Map<String, dynamic> _initalValue = {};

  // late ProductProvider productProvider;
  // late UnitOfMeasureProvider unitOfMeasureProvider;
  // late ProductTypeProvider productTypeProvider;

  late PeerChallengeProvider peerChallengeProvider;
  late UserProvider userProvider;
  SearchResult<PeerChallenge>? peerChallenges;
  // SearchResult<UnitOfMeasure>? unitOfMeasures;
  // SearchResult<ProductType>? productTypes;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    peerChallengeProvider = Provider.of<PeerChallengeProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);

    initFormData();
  }

  initFormData() async {
    peerChallenges = await peerChallengeProvider.get();
    var user = await userProvider.getCurrent();
    var currentUserId = user.id;
    _initalValue = {

      "izazivacId": currentUserId.toString(),
      "izazvaniId": widget.challenge?.izazvaniId.toString(),
      "challengeId": widget.challenge?.challengeId.toString(),
      "statusPeera": widget.challenge?.statusPeera,
      "datumKreiranja": DateTime.now(),
    };
    print("widget.challenge");
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
          if(request["datumKreiranja"]!=null && request["datumKreiranja"] is DateTime){
            request["datumKreiranja"]=(request["datumKreiranja"] as DateTime).toIso8601String();
          }
          if (widget.challenge == null) {
            widget.challenge = await peerChallengeProvider.insert(request);
          } else {
            widget.challenge = await peerChallengeProvider.update(widget.challenge!.peerChallengeId!, request);
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
                name: "izazvaniId",
                decoration: InputDecoration(labelText: "izazvaniId"),
              ),
              FormBuilderTextField(
                name: "challengeId",
                decoration: InputDecoration(labelText: "challengeId"),
              ),
              FormBuilderTextField(
                name: "statusPeera",
                decoration: InputDecoration(labelText: "statusPeera"),
              ),
            ],
          ),
        ));
  }
}
