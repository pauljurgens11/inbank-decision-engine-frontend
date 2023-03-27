import 'package:flutter/material.dart';

import '../utils/palette.dart';

/// TitlePage class is the landing page when first starting the application.
///
/// This page offers little real functionality.
class TitlePage extends StatefulWidget {
  const TitlePage({super.key});

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  /// Transition to LoanPage.
  void _goToLoanPage() {
    Navigator.of(context).pushNamed("loanpage");
  }

  /// All page-specific elements.
  Widget _pageElements() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 320.0,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Inbank Loan",
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(width: 6.0),
                Text(
                  "Calculator",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            ),
            const SizedBox(height: 48.0),
            SizedBox(
              width: 480.0,
              height: 48.0,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Palette.accentColor)),
                onPressed: () => _goToLoanPage(),
                child: Text(
                  'Continue',
                  style: Palette.inriaSansStyle(
                      color: Palette.lightGray, fontSize: 24.0),
                ),
              ),
            ),
            const SizedBox(height: 48.0),
          ],
        ),
      ),
    );
  }

  /// Build method.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(child: _pageElements()),
    );
  }
}
