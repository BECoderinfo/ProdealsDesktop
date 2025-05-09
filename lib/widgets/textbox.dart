import '../utils/imports.dart';

class TextBoxCustom extends StatelessWidget {
  final String? errorText;
  final TextEditingController controller;
  final String placeholder;
  final void Function(String)? onChange;
  final void Function()? onTap;
  final int? maxline;
  final bool? readOnly;
  final bool? obsecureText;
  final BoxDecoration? decoration;
  final Widget? suffix;

  const TextBoxCustom({
    super.key,
    required this.controller,
    required this.placeholder,
    required this.errorText,
    required this.onChange,
    this.maxline,
    this.readOnly,
    this.obsecureText,
    this.onTap,
    this.decoration,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FluentTheme(
          data: FluentThemeData.light(),
          child: TextBox(
            obscureText: obsecureText ?? false,
            readOnly: readOnly ?? false,
            cursorColor: Colors.black,
            onTap: onTap,
            controller: controller,
            onChanged: onChange,
            maxLines: maxline ?? 1,
            highlightColor: AppColor.primary,
            decoration:
                WidgetStateProperty.all(decoration ?? const BoxDecoration()),
            placeholder: placeholder,
            style: AppTextStyle.regularStyle(
              color: AppColor.smokyBlack,
              size: 15,
            ),
            suffix: suffix,
            placeholderStyle: AppTextStyle.regularStyle(
              color: AppColor.smokyBlack,
              size: 15,
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              errorText ?? "",
              style: AppTextStyle.regularStyle(
                color: Colors.red,
                size: 12,
              ),
            ),
          ),
      ],
    );
  }
}
