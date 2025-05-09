import '../utils/imports.dart';

class FluentThemeWidget extends StatelessWidget {
  final Widget widget;

  const FluentThemeWidget({
    super.key,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return FluentTheme(
      data: FluentThemeData.light(),
      child: widget,
    );
  }
}
