import 'package:pro_deals_admin/utils/imports.dart';

class AppTextStyle {
  static semiBoldStyle({
    required Color color,
    required int size,
  }) {
    return GoogleFonts.poppins(
      color: color,
      fontSize: size.toDouble(),
      fontWeight: FontWeight.w600,
    );
  }

  static boldStyle({
    required Color color,
    required int size,
  }) {
    return GoogleFonts.poppins(
      color: color,
      fontSize: size.toDouble(),
      fontWeight: FontWeight.w700,
    );
  }

  static regularStyle({
    required Color color,
    required int size,
  }) {
    return GoogleFonts.poppins(
      color: color,
      fontSize: size.toDouble(),
      fontWeight: FontWeight.w400,
    );
  }

  static mediumStyle({
    required Color color,
    required int size,
  }) {
    return GoogleFonts.poppins(
      color: color,
      fontSize: size.toDouble(),
      fontWeight: FontWeight.w500,
    );
  }
}
