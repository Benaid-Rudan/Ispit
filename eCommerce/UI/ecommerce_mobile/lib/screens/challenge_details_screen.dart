import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_mobile/layouts/master_screen.dart';
import 'package:ecommerce_mobile/model/peer_challenge.dart';
import 'package:ecommerce_mobile/model/product.dart';
import 'package:ecommerce_mobile/model/product_type.dart';
import 'package:ecommerce_mobile/model/search_result.dart';
import 'package:ecommerce_mobile/model/unit_of_measure.dart';
import 'package:ecommerce_mobile/model/user.dart';
import 'package:ecommerce_mobile/model/user_challenge.dart';
import 'package:ecommerce_mobile/providers/auth_provider.dart';
import 'package:ecommerce_mobile/providers/peer_challenge_provider.dart';
import 'package:ecommerce_mobile/providers/product_provider.dart';
import 'package:ecommerce_mobile/providers/product_type_provider.dart';
import 'package:ecommerce_mobile/providers/unit_of_measure_provider.dart';
import 'package:ecommerce_mobile/providers/user_challenge_provider.dart';
import 'package:ecommerce_mobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:file_picker/file_picker.dart';

class ChallengeDetailsScreen extends StatefulWidget {
  // Product? product;
  PeerChallenge? peerChallenge;
  UserChallenge? userChallenge;
  ChallengeDetailsScreen({super.key, this.peerChallenge, this.userChallenge});

  @override
  State<ChallengeDetailsScreen> createState() => _ChallengeDetailsScreenState();
}

class _ChallengeDetailsScreenState extends State<ChallengeDetailsScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  Map<String, dynamic> _initalValue = {};

  // late ProductProvider productProvider;
  late PeerChallengeProvider peerChallengeProvider;
  late UserProvider userProvider;

  // late UnitOfMeasureProvider unitOfMeasureProvider;
  // late ProductTypeProvider productTypeProvider;

  // SearchResult<UnitOfMeasure>? unitOfMeasures;
  // SearchResult<ProductType>? productTypes;
  SearchResult<PeerChallenge>? peerChallengeTypes;
  bool isLoading = true;

  @override
void initState() {
  super.initState();
  peerChallengeProvider = Provider.of<PeerChallengeProvider>(context, listen: false);
  userProvider = Provider.of<UserProvider>(context, listen: false);
  _loadCurrentUser();
}

Future<void> _loadCurrentUser() async {
  var currentUser = await userProvider.getMe();
  int? currentUserId = currentUser.id;

  _initalValue = {
    "izazivacId": currentUserId?.toString() ?? "",
    "izazvaniId": widget.peerChallenge?.izazvaniId?.toString() ?? "",
    "challengeId": widget.peerChallenge?.challengeId?.toString() ?? "",
    "status": widget.peerChallenge?.status ?? "",
    "datumKreiranja": DateTime.now(),
  };

  print("Initial: $_initalValue");
  initFormData();
}


  initFormData() async {
    peerChallengeTypes = await peerChallengeProvider.get();
    // productTypes = await productTypeProvider.get();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Peer Challenges Details",
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
          request["izazivacId"] = _initalValue["izazivacId"];
          if (request["datumKreiranja"] is DateTime) {
            request["datumKreiranja"] = (request["datumKreiranja"] as DateTime).toIso8601String();
          }
            // Provjera postoji li već aktivni peer izazov između istih korisnika s statusom 'Prihvacen' ili 'Utoku'
              var existing = await peerChallengeProvider.get(filter: {
                "izazivacId": request["izazivacId"],
                "izazvaniId": request["izazvaniId"],
              });
              if (existing.items != null && existing.items!.any((pc) =>
                  pc.status == "Poslan")) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Greška"),
                    content: Text("Već postoji aktivan peer izazov između ovih korisnika."),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("OK"),
                      )
                    ],
                  ),
                );
                return;
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
          // Brojčana polja
          FormBuilderTextField(
            name: "izazvaniId",
            decoration: InputDecoration(labelText: "izazvaniId"),
            keyboardType: TextInputType.number,
          ),
          FormBuilderTextField(
            name: "challengeId",
            decoration: InputDecoration(labelText: "challengeId"),
            keyboardType: TextInputType.number,
          ),
          
          // Dropdown za status
          FormBuilderTextField(
            name: "status",
            decoration: InputDecoration(labelText: "Status"),
            keyboardType: TextInputType.text,
          ),
          
          // Datum picker
          FormBuilderDateTimePicker(
            name: "datumKreiranja",
            decoration: InputDecoration(labelText: "Datum kreiranja"),
            inputType: InputType.date,
          ),
        ],
      ),
    ),
  );
}
}
