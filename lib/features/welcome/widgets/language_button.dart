import 'package:flutter/material.dart';
import 'package:whatsapp_messenger/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_messenger/common/utils/colors.dart';

import '../../../common/widgets/custom_icon_button.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                width: 30,
                decoration: BoxDecoration(
                  // Providing a default color if greyColor is null
                  color: context.theme.greyColor?.withOpacity(.4) ??
                      Colors.grey.withOpacity(.4),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 20),
                  CustomIconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icons.close,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'App Language',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Divider(
                thickness: .5,
                // Providing a default color if greyColor is null
                color: context.theme.greyColor?.withOpacity(.3) ??
                    Colors.grey.withOpacity(.3),
              ),
              RadioListTile<bool>(
                value: true,
                groupValue:
                    true, // This should ideally be a boolean or a type same as `value`
                onChanged: (bool? value) {},
                activeColor: MyColors.greenDark,
                title: const Text('English'),
                subtitle: Text(
                  "(Phone's language)",
                  style: TextStyle(
                    // Providing a default color if greyColor is null
                    color: context.theme.greyColor ?? Colors.grey,
                  ),
                ),
              ),
              RadioListTile<bool>(
                value: false,
                groupValue:
                    false, // Ensuring groupValue is the same type as `value`
                onChanged: (bool? value) {},
                activeColor: MyColors.greenDark,
                title: const Text('አማርኛ'),
                subtitle: Text(
                  "Amharic",
                  style: TextStyle(
                    // Providing a default color if greyColor is null
                    color: context.theme.greyColor ?? Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      // Providing a default color if langBgColor is null
      color: context.theme.langBgColor ?? Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => showBottomSheet(context),
        borderRadius: BorderRadius.circular(20),
        splashFactory: NoSplash.splashFactory,
        // Providing a default color if langHighlightColor is null
        highlightColor:
            context.theme.langHighlightColor ?? Colors.grey.withOpacity(0.2),
        child: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.language,
                color: MyColors.greenDark,
              ),
              SizedBox(width: 10),
              Text(
                'English',
                style: TextStyle(
                  color: MyColors.greenDark,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.keyboard_arrow_down,
                color: MyColors.greenDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
