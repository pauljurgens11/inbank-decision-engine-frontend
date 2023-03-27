import 'package:flutter/material.dart';

import '../../utils/palette.dart';
import '../loan_page.dart';

/// ResponseBuilder class is a widget on the LoanPage.
///
/// This class builds a response on the screen when a response has been received
/// from the server.
class ResponseBuilder extends StatelessWidget {
  /// Variable where the response is stored when a client applies for a loan.
  final Future<Map<String, dynamic>>? response = LoanPageState.response;

  /// Constructor.
  ResponseBuilder({Key? key}) : super(key: key);

  /// Build the response.
  Widget _buildResponse() {
    return FutureBuilder(
        future: response,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              // If response is successful
              if (snapshot.data["response"]) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        snapshot.data["message"],
                        style: Palette.inriaSansStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12.0),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Loan amount:',
                                    style:
                                        Palette.inriaSansStyle(fontSize: 16.0)),
                                RichText(
                                  text: TextSpan(
                                    text: snapshot.data["loanAmount"],
                                    style: Palette.inriaSansStyle(
                                      fontSize: 42.0,
                                      color: Palette.accentColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: ' €',
                                        style: Palette.inriaSansStyle(
                                          fontSize: 28.0,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Loan period:',
                                    style:
                                        Palette.inriaSansStyle(fontSize: 16.0)),
                                RichText(
                                  text: TextSpan(
                                    text: snapshot.data["loanPeriod"],
                                    style: Palette.inriaSansStyle(
                                      fontSize: 42.0,
                                      color: Palette.accentColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: ' months',
                                        style: Palette.inriaSansStyle(
                                          fontSize: 28.0,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ],
                  ),
                );
              }
              // If response isn't successful.
              else {
                return Text(
                  snapshot.data["message"],
                  style: Palette.inriaSansStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                );
              }
            }
          }
          return const SizedBox();
        });
  }

  /// Build method.
  @override
  Widget build(BuildContext context) {
    return (response != null) ? _buildResponse() : const SizedBox();
  }
}
