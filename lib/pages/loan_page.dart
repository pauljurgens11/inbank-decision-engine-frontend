import 'package:decisionengine_frontend/pages/widgets/loan_page_form.dart';
import 'package:decisionengine_frontend/pages/widgets/loan_page_response_builder.dart';
import 'package:flutter/material.dart';

import '../utils/palette.dart';

/// LoanPage class is where the main logic of the application is situated.
///
/// On this page, the client can apply for a loan, and see the response of their
/// application.
class LoanPage extends StatefulWidget {
  const LoanPage({super.key});

  @override
  State<LoanPage> createState() => LoanPageState();
}

class LoanPageState extends State<LoanPage> {
  /// Key that enables seeing the form's validation state.
  final GlobalKey<LoanPageFormFieldsState> _loanPageFormFieldsKey = GlobalKey();

  /// Variable where the response is stored when a client applies for a loan.
  static Future<Map<String, dynamic>>? response;

  /// Whether the current form is validated and can be submitted.
  static bool _isValid = false;

  /// Whether LoanPageState has received a response from the server.
  static bool _hasReceivedResponse = false;

  /// Transition to TitlePage.
  void _goToTitlePage() {
    Navigator.of(context).pushNamed("titlepage");
  }

  /// Submit button widget.
  Widget _submitButton() {
    return SizedBox(
      width: 360.0,
      height: 48.0,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Palette.accentColor.withOpacity(0.7);
              }
              return Palette.accentColor;
            },
          ),
        ),
        onPressed: _isValid
            ? () {
                setState(() {
                  response = _loanPageFormFieldsKey.currentState?.submitForm();
                  _hasReceivedResponse = true;
                });
              }
            : null,
        child: Text(
          'Submit',
          style:
              Palette.inriaSansStyle(color: Palette.lightGray, fontSize: 24.0),
        ),
      ),
    );
  }

  /// All page-specific elements.
  Widget _pageElements() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Inbank Loan Calculator",
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: 32.0),
          // Build all form fields and sliders
          LoanPageFormFields(
            key: _loanPageFormFieldsKey,
            onValidationStateChange: (bool isValid) {
              setState(() {
                _isValid = isValid;
              });
            },
          ),
          // Display and animate the response
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: AnimatedContainer(
              width: MediaQuery.of(context).size.width / 2.5,
              height: _hasReceivedResponse ? 140.0 : 1.0,
              color: _hasReceivedResponse
                  ? Theme.of(context).cardColor
                  : Palette.transparent,
              alignment: Alignment.center,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              child: ResponseBuilder(),
            ),
          ),
          const SizedBox(height: 32.0),
          _submitButton(),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }

  /// Build method.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: IconButton(
              onPressed: () => _goToTitlePage(),
              icon: const Icon(Icons.keyboard_arrow_up, size: 36.0),
              splashRadius: 1.0,
              color: Theme.of(context).textTheme.headline2?.color,
            ),
          ),
        ),
        Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width / 2.2,
              child: _pageElements()),
        ),
      ]),
    );
  }
}
