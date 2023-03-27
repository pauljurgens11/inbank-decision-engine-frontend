import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants.dart';
import '../../utils/palette.dart';

/// LoanPageFormFields class is a group of widgets on the LoanPage.
///
/// This class builds all the visible text fields and sliders, while constantly
/// tracking and validating their values.
class LoanPageFormFields extends StatefulWidget {
  /// Callback to parent – notifies parent whether the fields are validated or not
  final ValidationCallBack onValidationStateChange;

  const LoanPageFormFields({Key? key, required this.onValidationStateChange})
      : super(key: key);

  @override
  State<LoanPageFormFields> createState() => LoanPageFormFieldsState();
}

class LoanPageFormFieldsState extends State<LoanPageFormFields> {
  /// Form key for all text fields.
  final _formKey = GlobalKey<FormState>();

  /// Controllers for all text fields (and sliders).
  static final TextEditingController _personalCodeController =
      TextEditingController();
  static final TextEditingController _loanAmountSliderController =
      TextEditingController();
  static final TextEditingController _loanPeriodSliderController =
      TextEditingController();

  /// Initial values for text fields.
  static int _currentLoanAmountValue = 3000;
  static int _currentLoanPeriodValue = 60;

  /// Init method.
  @override
  void initState() {
    super.initState();

    if (_loanAmountSliderController.text == "") {
      _loanAmountSliderController.text = "3000";
    }

    if (_loanPeriodSliderController.text == "") {
      _loanPeriodSliderController.text = "60";
    }
  }

  /// Submit form method.
  ///
  /// Get's called when fields are all validated and client presses on the
  /// "submit" button. This method handles communication with the server.
  Future<Map<String, dynamic>> submitForm() async {
    Map<String, String> data = {
      'personalCode': _personalCodeController.text,
      'loanAmount': _loanAmountSliderController.text,
      'loanPeriod': _loanPeriodSliderController.text,
    };

    try {
      http.Response response = await http.post(
        Uri.parse('http://localhost:8080/api/engine'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> result = json.decode(response.body);
        return result;
      }
      throw Exception();
    } on Exception catch (_, __) {
      Map<String, dynamic> result = {
        "response": false,
        "message": "Couldn't connect to server. Check if server is running."
      };
      return result;
    }
  }

  /// Update the current text fields validation state (gets sent to the parent class).
  void _updateValidationState() {
    widget.onValidationStateChange(_formKey.currentState!.validate());
  }

  /// Text field for the client's personal code.
  Widget _personalCodeTextFormField() {
    return SizedBox(
      height: 96.0,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 6.0, bottom: 2.0),
              child: Text(
                "Personal code:",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            controller: _personalCodeController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).cardColor,
              hintText: "00000000000",
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              // TODO: ADD SUFFIX
            ),
            validator: (code) {
              if (code != null) {
                if (code.length != 11) {
                  return "Enter a code with 11 digits.";
                }
              }
              return null;
            },
            onChanged: (code) => _updateValidationState(),
          ),
        ],
      ),
    );
  }

  /// Text field and slider for the loan amount entered by the client.
  Widget _loanAmountTextFormField() {
    return SizedBox(
      height: 96.0,
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: Slider(
              activeColor: Palette.secondaryAccentColor,
              inactiveColor: Palette.lightGray,
              value: _currentLoanAmountValue.toDouble(),
              min: Constants.loanAmountMinValue.toDouble(),
              max: Constants.loanAmountMaxValue.toDouble(),
              divisions: 80,
              label: _currentLoanAmountValue.round().toString(),
              onChanged: (double value) {
                _updateValidationState();
                setState(() {
                  _currentLoanAmountValue = value.toInt();
                  _loanAmountSliderController.text =
                      _currentLoanAmountValue.toString();
                });
              },
            ),
          ),
          Flexible(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                      child: Text(
                        "Loan amount:",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                      suffixText: "EUR",
                      border: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                    ),
                    controller: _loanAmountSliderController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (code) {
                      setState(() {
                        _updateValidationState();
                        if (code != "" && code != "") {
                          if (int.parse(code) < Constants.loanAmountMinValue) {
                            _currentLoanAmountValue =
                                Constants.loanAmountMinValue;
                          } else if (int.parse(code) >
                              Constants.loanAmountMaxValue) {
                            _currentLoanAmountValue =
                                Constants.loanAmountMaxValue;
                          } else {
                            _currentLoanAmountValue = int.parse(code);
                          }
                        }
                      });
                    },
                    validator: (code) {
                      if (code != null && code != "") {
                        if (int.parse(code) < Constants.loanAmountMinValue ||
                            int.parse(code) > Constants.loanAmountMaxValue) {
                          return "Between ${Constants.loanAmountMinValue} and ${Constants.loanAmountMaxValue}.";
                        }
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Text field and slider for the loan period entered by the client.
  Widget _loanPeriodTextFormField() {
    return SizedBox(
      height: 96.0,
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: Slider(
              activeColor: Palette.secondaryAccentColor,
              inactiveColor: Palette.lightGray,
              value: _currentLoanPeriodValue.toDouble(),
              min: Constants.loanPeriodMinValue.toDouble(),
              max: Constants.loanPeriodMaxValue.toDouble(),
              label: _currentLoanPeriodValue.round().toString(),
              onChanged: (double value) {
                _updateValidationState();
                setState(() {
                  _currentLoanPeriodValue = value.toInt();
                  _loanPeriodSliderController.text =
                      _currentLoanPeriodValue.toString();
                });
              },
            ),
          ),
          Flexible(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                      child: Text(
                        "Loan period:",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        suffixText: "months",
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                        errorStyle:
                            TextStyle(color: Theme.of(context).errorColor)),
                    controller: _loanPeriodSliderController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (code) {
                      _updateValidationState();
                      setState(() {
                        if (code != "" && code != "") {
                          if (int.parse(code) < Constants.loanPeriodMinValue) {
                            _currentLoanPeriodValue =
                                Constants.loanPeriodMinValue;
                          } else if (int.parse(code) >
                              Constants.loanPeriodMaxValue) {
                            _currentLoanPeriodValue =
                                Constants.loanPeriodMaxValue;
                          } else {
                            _currentLoanPeriodValue = int.parse(code);
                          }
                        }
                      });
                    },
                    validator: (code) {
                      if (code != null && code != "") {
                        if (int.parse(code) < Constants.loanPeriodMinValue ||
                            int.parse(code) > Constants.loanPeriodMaxValue) {
                          return "Between ${Constants.loanPeriodMinValue} and ${Constants.loanPeriodMaxValue}.";
                        }
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build method.
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _personalCodeTextFormField(),
          _loanAmountTextFormField(),
          const SizedBox(height: 16.0),
          _loanPeriodTextFormField(),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

/// Callback to parent.
typedef ValidationCallBack = void Function(bool isValid);
