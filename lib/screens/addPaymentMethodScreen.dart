import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddPaymentMethodScreen extends BaseRoute {
  AddPaymentMethodScreen({a, o})
      : super(a: a, o: o, r: 'AddPaymentMethodScreen');
  @override
  _AddPaymentMethodScreenState createState() =>
      new _AddPaymentMethodScreenState();
}

class _AddPaymentMethodScreenState extends BaseRouteState {
  TextEditingController _cCardNumber = new TextEditingController();
  TextEditingController _cCardHolderName = new TextEditingController();
  TextEditingController _cExpiryDate = new TextEditingController();
  TextEditingController _cCVV = new TextEditingController();
  FocusNode _fCardNumber = new FocusNode();
  FocusNode _fCardHolderName = new FocusNode();
  FocusNode _fExpiryDate = new FocusNode();
  FocusNode _fCVV = new FocusNode();
  _AddPaymentMethodScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop();
          return true;
        },
        child: sc(Scaffold(
            appBar: AppBar(
              title: AutoSizeText('Add Payment Method'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 180,
                    width: 300,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/c2.jpg'))),
                  ),
                  Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 10, right: 10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            'Card Number',
                            style:
                                Theme.of(context).primaryTextTheme.titleMedium,
                          ))),
                  Padding(
                    padding: const EdgeInsets.only(top: 3, left: 10, right: 10),
                    child: Container(
                        height: 50,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          autofocus: false,
                          cursorColor: Color(0xFFF36D86),
                          enabled: true,
                          style: Theme.of(context).primaryTextTheme.headline6,
                          controller: _cCardNumber,
                          focusNode: _fCardNumber,
                          onEditingComplete: () {
                            _fCardHolderName.requestFocus();
                          },
                          decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.credit_card_outlined,
                                color: Theme.of(context)
                                    .iconTheme
                                    .color!
                                    .withOpacity(0.5),
                                size: 18,
                              ),
                              hintText: "Card Number"),
                        )),
                  ),
                  Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 10, right: 10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            'Card Holder Name',
                            style:
                                Theme.of(context).primaryTextTheme.titleMedium,
                          ))),
                  Padding(
                    padding: const EdgeInsets.only(top: 3, left: 10, right: 10),
                    child: Container(
                        height: 50,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          autofocus: false,
                          cursorColor: Color(0xFFF36D86),
                          enabled: true,
                          style: Theme.of(context).primaryTextTheme.headline6,
                          controller: _cCardHolderName,
                          focusNode: _fCardHolderName,
                          onEditingComplete: () {
                            _fExpiryDate.requestFocus();
                          },
                          decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.person_outline,
                                color: Theme.of(context)
                                    .iconTheme
                                    .color!
                                    .withOpacity(0.5),
                                size: 18,
                              ),
                              hintText: "Card Holder Name"),
                        )),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 0, left: 0, right: 10),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: AutoSizeText(
                                      'Expiry Date',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .titleMedium,
                                    ))),
                            Padding(
                              padding: const EdgeInsets.only(right: 4, top: 3),
                              child: SizedBox(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20,
                                  child: TextFormField(
                                    textAlign: TextAlign.start,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    keyboardType: TextInputType.number,
                                    autofocus: false,
                                    cursorColor: Color(0xFFF36D86),
                                    enabled: true,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headline6,
                                    controller: _cExpiryDate,
                                    focusNode: _fExpiryDate,
                                    onEditingComplete: () {
                                      _fCVV.requestFocus();
                                    },
                                    decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          MdiIcons.calendar,
                                          color: Theme.of(context)
                                              .iconTheme
                                              .color!
                                              .withOpacity(0.5),
                                          size: 18,
                                        ),
                                        hintText: "Expiry Date"),
                                  )),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 0, left: 0, right: 10),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: AutoSizeText(
                                      'Security Code',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .titleMedium,
                                    ))),
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: SizedBox(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20,
                                  child: TextFormField(
                                    textAlign: TextAlign.start,
                                    keyboardType: TextInputType.number,
                                    autofocus: false,
                                    cursorColor: Color(0xFFF36D86),
                                    enabled: true,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headline6,
                                    controller: _cCVV,
                                    focusNode: _fCVV,
                                    onEditingComplete: () {
                                      FocusScope.of(context).unfocus();
                                    },
                                    decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          MdiIcons.keyVariant,
                                          color: Theme.of(context)
                                              .iconTheme
                                              .color!
                                              .withOpacity(0.5),
                                          size: 18,
                                        ),
                                        hintText: "Security Code"),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: 50,
                      width: 150,
                      margin: EdgeInsets.only(top: 15),
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: AutoSizeText('Save'))),
                ],
              ),
            ))));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
}
