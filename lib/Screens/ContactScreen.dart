// ignore_for_file: file_names, prefer_const_constructors_in_immutables, non_constant_identifier_names, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../design.dart';

class ContactWidget extends StatefulWidget {
  const ContactWidget({Key? key}) : super(key: key);

  @override
  _ContactWidgetState createState() => _ContactWidgetState();
}

TextEditingController titleController = TextEditingController();
TextEditingController mailController = TextEditingController();
TextEditingController msgController = TextEditingController();

class _ContactWidgetState extends State<ContactWidget> {
  bool send = false;

  Future sendEmail({
    required String email,
    required String subject,
    required String msg,
  }) async {
    const serviceId = 'service_997oz8f';
    const templateId = 'template_rakged6';
    const userId = 'user_cq2pgt1VoP3xQwRJ3vPaw';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_email': email,
          'user_subject': subject,
          'user_message': msg,
        }
      }),
    );

    //print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(
            left: kDefaultPadding, right: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Row(
                children: [
                  Text(
                    "CONTACT",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Theme.of(context).focusColor,
                      fontFamily: 'Roboto',
                      fontSize: kPageTitleSize,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ],
              ),
            ),
            InputCard(
              title: "Subject:",
              txtController: titleController,
            ),
            InputCard(
              title: "E-Mail / Your Name: (optional)",
              txtController: mailController,
            ),
            InputCard(
              title: "Message:",
              txtController: msgController,
            ),
            const SizedBox(height: kDefaultPadding * 2),
            GestureDetector(
              onTap: () {
                String title, mail, msg;
                title = titleController.text.toString();
                mail = mailController.text.toString();
                msg = msgController.text.toString();

                print("title:" + title);
                print("mail:" + mail);
                print("msg:" + msg);

                if (titleController.text.isNotEmpty &&
                    msgController.text.isNotEmpty) {
                  print("SENDED!");
                  setState(() {
                    send = true;
                    titleController.clear();
                    msgController.clear();
                    mailController.clear();
                  });

                  sendEmail(email: mail, subject: title, msg: msg);
                }
              },
              child: Container(
                height: 70.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2.0,
                    color: Theme.of(context).focusColor,
                  ),
                  borderRadius: BorderRadius.circular(kDefaultPadding),
                ),
                child: Center(
                  child: Text(
                    "(Full) Send",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).focusColor,
                      fontFamily: 'Roboto',
                      fontSize: kScndTitleSize,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: kDefaultPadding),
            send == true
                ? Center(
                    child: Text(
                      "Thanks for your message!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).focusColor,
                        fontFamily: 'Roboto',
                        fontSize: kFontSize,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class InputCard extends StatelessWidget {
  InputCard({required this.title, required this.txtController, Key? key})
      : super(key: key);

  String title;
  TextEditingController txtController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Theme.of(context).focusColor,
              fontFamily: 'Roboto',
              fontSize: kScndTitleSize,
              fontWeight: FontWeight.w100,
            ),
          ),
          const SizedBox(height: kDefaultPadding),
          TextField(
            controller: txtController,
            cursorColor: Theme.of(context).focusColor,
            style: TextStyle(
              color: Theme.of(context).focusColor,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).backgroundColor,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).focusColor.withOpacity(0.7),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).focusColor,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
