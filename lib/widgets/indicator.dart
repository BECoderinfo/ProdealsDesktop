import '../utils/imports.dart';

class CustomCircularIndicator {
  static Widget indicator({
    required Color color,
    required Color color1,
  }) {
    return Center(
      child: ProgressRing(
        activeColor: color,
        backgroundColor: color1,
      ),
    );
  }
}
