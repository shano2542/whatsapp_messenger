import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_messenger/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_messenger/common/utils/colors.dart';
import 'package:whatsapp_messenger/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp_messenger/features/auth/widgets/custom_text_field.dart';

import '../../../common/helper/show_alert_dialogue.dart';
import '../../../common/widgets/custom_icon_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController countryNameController;
  late TextEditingController countryCodeController;
  late TextEditingController countryNumberController;

  sendCodeToPhone() {
    final phoneNumber = countryNumberController.text;
    final countryName = countryNameController.text;
    final countryCode = countryCodeController.text;

    if (phoneNumber.isEmpty) {
      return showAlertDialog(
        context: context,
        message: "Please enter your phone number",
      );
    } else if (phoneNumber.length < 9) {
      return showAlertDialog(
        context: context,
        message:
            'The phone number you entered is too short for the country: $countryName\n\nInclude your area code if you haven\'t',
      );
    } else if (phoneNumber.length > 10) {
      return showAlertDialog(
        context: context,
        message:
            "The phone number you entered is too long for the country: $countryName",
      );
    }
    //
    // ref.read(authControllerProvider).sendSmsCode(
    //   context: context,
    //   phoneNumber: "+$countryCode$phoneNumber",
    // );
  }

  showCountryCodePicker() {
    showCountryPicker(
        context: context,
        showPhoneCode: true,
        favorite: ['ET'],
        countryListTheme: CountryListThemeData(
          bottomSheetHeight: 600,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          flagSize: 22,
          borderRadius: BorderRadius.circular(20),
          textStyle: TextStyle(color: context.theme.greyColor),
          inputDecoration: InputDecoration(
            labelStyle: TextStyle(color: context.theme.greyColor),
            prefixIcon: const Icon(
              Icons.language,
              color: MyColors.greenDark,
            ),
            hintText: 'Search Country Code or Name',
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.theme.greyColor!.withOpacity(0.2),
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: MyColors.greenDark,
              ),
            ),
          ),
        ),
        onSelect: (country) {
          countryNameController.text = country.name;
          countryCodeController.text = country.countryCode;
        });
  }

  @override
  void initState() {
    // TODO: implement initState

    countryNameController = TextEditingController(text: 'Ethiopia');
    countryCodeController = TextEditingController(text: '251');
    countryNumberController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    countryNameController.dispose();
    countryCodeController.dispose();
    countryNumberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Enter Your Phone Number',
          style: TextStyle(
            color: context.theme.authAppbarTextColor,
          ),
        ),
        centerTitle: true,
        actions: [
          CustomIconButton(
            onPressed: () {},
            icon: Icons.more_vert,
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'WhatsApp will need to verify your phone number. ',
                    style: TextStyle(
                      color: context.theme.greyColor,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: "What's my number?",
                        style: TextStyle(color: context.theme.blueColor),
                      )
                    ]),
              )),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: CustomTextField(
              onTap: showCountryCodePicker,
              controller: countryNameController,
              readOnly: true,
              suffixIcon: const Icon(
                Icons.arrow_drop_down,
                color: MyColors.greenDark,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              children: [
                SizedBox(
                  width: 70,
                  child: CustomTextField(
                    onTap: showCountryCodePicker,
                    controller: countryCodeController,
                    prefixText: '+',
                    readOnly: true,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomTextField(
                    controller: countryNumberController,
                    hintText: 'Phone Number',
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.number,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Carrier charges may apply',
            style: TextStyle(
              color: context.theme.greyColor,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        onPressed: sendCodeToPhone,
        text: 'NEXT',
        buttonWidth: 90,
      ),
    );
  }
}