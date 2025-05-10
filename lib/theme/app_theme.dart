import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the Pet Shop application.
class AppTheme {
  AppTheme._();

  // Primary colors - Teal
  static const Color primary50 = Color(0xFFF0FDFA);
  static const Color primary100 = Color(0xFFCCFBF1);
  static const Color primary200 = Color(0xFF99F6E4);
  static const Color primary300 = Color(0xFF5EEAD4);
  static const Color primary400 = Color(0xFF2DD4BF);
  static const Color primary500 = Color(0xFF14B8A6);
  static const Color primary600 = Color(0xFF0D9488);
  static const Color primary700 = Color(0xFF0F766E);
  static const Color primary800 = Color(0xFF115E59);
  static const Color primary900 = Color(0xFF134E4A);

  // Neutral colors - Slate
  static const Color neutral50 = Color(0xFFF8FAFC);
  static const Color neutral100 = Color(0xFFF1F5F9);
  static const Color neutral200 = Color(0xFFE2E8F0);
  static const Color neutral300 = Color(0xFFCBD5E1);
  static const Color neutral400 = Color(0xFF94A3B8);
  static const Color neutral500 = Color(0xFF64748B);
  static const Color neutral600 = Color(0xFF475569);
  static const Color neutral700 = Color(0xFF334155);
  static const Color neutral800 = Color(0xFF1E293B);
  static const Color neutral900 = Color(0xFF0F172A);

  // Semantic colors
  static const Color success600 = Color(0xFF059669);
  static const Color success100 = Color(0xFFD1FAE5);
  static const Color warning600 = Color(0xFFD97706);
  static const Color warning100 = Color(0xFFFEF3C7);
  static const Color error600 = Color(0xFFE11D48);
  static const Color error100 = Color(0xFFFFE4E6);
  static const Color info600 = Color(0xFF0284C7);
  static const Color info100 = Color(0xFFE0F2FE);

  // Pet status colors
  static const Color available500 = Color(0xFF22C55E);
  static const Color pending500 = Color(0xFFEAB308);
  static const Color sold500 = Color(0xFFEF4444);

  // Shadow colors
  static const Color shadowLight = Color(0x1F000000);
  static const Color shadowDark = Color(0x1FFFFFFF);

  // Text colors
  static const Color textHighEmphasisLight = Color(0xFF0F172A); // neutral-900
  static const Color textMediumEmphasisLight = Color(0xFF475569); // neutral-600
  static const Color textDisabledLight = Color(0xFF94A3B8); // neutral-400

  static const Color textHighEmphasisDark = Color(0xFFF8FAFC); // neutral-50
  static const Color textMediumEmphasisDark = Color(0xFFCBD5E1); // neutral-300
  static const Color textDisabledDark = Color(0xFF64748B); // neutral-500

  /// Light theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primary700,
      onPrimary: Colors.white,
      primaryContainer: primary100,
      onPrimaryContainer: primary900,
      secondary: primary500,
      onSecondary: Colors.white,
      secondaryContainer: primary200,
      onSecondaryContainer: primary900,
      tertiary: info600,
      onTertiary: Colors.white,
      tertiaryContainer: info100,
      onTertiaryContainer: Color(0xFF0C4A6E),
      error: error600,
      onError: Colors.white,
      errorContainer: error100,
      onErrorContainer: Color(0xFF7F1D1D),
      surface: Colors.white,
      onSurface: neutral900,
      surfaceContainerHighest: neutral100,
      onSurfaceVariant: neutral700,
      outline: neutral300,
      outlineVariant: neutral200,
      shadow: shadowLight,
      scrim: Color(0x66000000),
      inverseSurface: neutral800,
      onInverseSurface: neutral100,
      inversePrimary: primary300,
    ),
    scaffoldBackgroundColor: neutral50,
    cardColor: Colors.white,
    dividerColor: neutral200,
    appBarTheme: const AppBarTheme(
      color: primary900,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      clipBehavior: Clip.antiAlias,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primary700,
      unselectedItemColor: neutral500,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary600,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: CircleBorder(),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: primary700,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 2,
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary700,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: const BorderSide(color: primary700, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary700,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ),
    ),
    textTheme: _buildTextTheme(isLight: true),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: neutral300, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: neutral300, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: primary600, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: error600, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: error600, width: 2.0),
      ),
      labelStyle: GoogleFonts.inter(
        color: neutral600,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: neutral400,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      helperStyle: GoogleFonts.inter(
        color: neutral500,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: GoogleFonts.inter(
        color: error600,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      prefixIconColor: neutral600,
      suffixIconColor: neutral600,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primary600;
        }
        return neutral300;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primary200;
        }
        return neutral200;
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primary600;
        }
        return null;
      }),
      checkColor: WidgetStateProperty.all(Colors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primary600;
        }
        return neutral400;
      }),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primary600,
      circularTrackColor: primary100,
      linearTrackColor: primary100,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: primary600,
      thumbColor: primary600,
      overlayColor: primary200.withAlpha(77),
      inactiveTrackColor: neutral200,
      valueIndicatorColor: primary700,
      valueIndicatorTextStyle: const TextStyle(color: Colors.white),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: primary700,
      unselectedLabelColor: neutral500,
      indicatorColor: primary700,
      labelStyle: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: neutral800,
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: const TextStyle(color: Colors.white),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: neutral800,
      contentTextStyle: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      actionTextColor: primary300,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: neutral100,
      disabledColor: neutral200,
      selectedColor: primary100,
      secondarySelectedColor: primary100,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle: GoogleFonts.inter(
        color: neutral700,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      secondaryLabelStyle: GoogleFonts.inter(
        color: primary700,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    badgeTheme: const BadgeThemeData(
      backgroundColor: primary600,
      textColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    ),
    dialogTheme: DialogThemeData(backgroundColor: Colors.white),
  );

  /// Dark theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: primary400,
      onPrimary: primary900,
      primaryContainer: primary800,
      onPrimaryContainer: primary100,
      secondary: primary300,
      onSecondary: primary900,
      secondaryContainer: primary700,
      onSecondaryContainer: primary100,
      tertiary: info600,
      onTertiary: Color(0xFF0C4A6E),
      tertiaryContainer: Color(0xFF075985),
      onTertiaryContainer: info100,
      error: error100,
      onError: Color(0xFF7F1D1D),
      errorContainer: Color(0xFF8E2C2C),
      onErrorContainer: error100,
      surface: neutral800,
      onSurface: neutral100,
      surfaceContainerHighest: neutral700,
      onSurfaceVariant: neutral300,
      outline: neutral600,
      outlineVariant: neutral700,
      shadow: shadowDark,
      scrim: Color(0x99000000),
      inverseSurface: neutral100,
      onInverseSurface: neutral800,
      inversePrimary: primary700,
    ),
    scaffoldBackgroundColor: neutral900,
    cardColor: neutral800,
    dividerColor: neutral700,
    appBarTheme: const AppBarTheme(
      color: neutral800,
      foregroundColor: neutral100,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardTheme(
      color: neutral800,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      clipBehavior: Clip.antiAlias,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: neutral800,
      selectedItemColor: primary400,
      unselectedItemColor: neutral400,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary400,
      foregroundColor: primary900,
      elevation: 4,
      shape: CircleBorder(),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: primary900,
        backgroundColor: primary400,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 2,
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary400,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: const BorderSide(color: primary400, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary400,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ),
    ),
    textTheme: _buildTextTheme(isLight: false),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: neutral800,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: neutral600, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: neutral600, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: primary400, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: error100, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: error100, width: 2.0),
      ),
      labelStyle: GoogleFonts.inter(
        color: neutral300,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: neutral500,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      helperStyle: GoogleFonts.inter(
        color: neutral400,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: GoogleFonts.inter(
        color: error100,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      prefixIconColor: neutral400,
      suffixIconColor: neutral400,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primary400;
        }
        return neutral600;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primary700;
        }
        return neutral700;
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primary400;
        }
        return null;
      }),
      checkColor: WidgetStateProperty.all(primary900),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primary400;
        }
        return neutral500;
      }),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primary400,
      circularTrackColor: primary800,
      linearTrackColor: primary800,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: primary400,
      thumbColor: primary400,
      overlayColor: primary700.withAlpha(77),
      inactiveTrackColor: neutral700,
      valueIndicatorColor: primary400,
      valueIndicatorTextStyle: const TextStyle(color: primary900),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: primary400,
      unselectedLabelColor: neutral400,
      indicatorColor: primary400,
      labelStyle: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: neutral700,
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: const TextStyle(color: neutral100),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: neutral700,
      contentTextStyle: GoogleFonts.inter(
        color: neutral100,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      actionTextColor: primary300,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: neutral700,
      disabledColor: neutral800,
      selectedColor: primary700,
      secondarySelectedColor: primary700,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle: GoogleFonts.inter(
        color: neutral200,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      secondaryLabelStyle: GoogleFonts.inter(
        color: primary200,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    badgeTheme: const BadgeThemeData(
      backgroundColor: primary400,
      textColor: primary900,
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    ),
    dialogTheme: DialogThemeData(backgroundColor: neutral800),
  );

  /// Helper method to build text theme based on brightness
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color textHighEmphasis =
        isLight ? textHighEmphasisLight : textHighEmphasisDark;
    final Color textMediumEmphasis =
        isLight ? textMediumEmphasisLight : textMediumEmphasisDark;
    final Color textDisabled = isLight ? textDisabledLight : textDisabledDark;

    // Using Google Fonts for Inter (primary) and Montserrat (display)
    return TextTheme(
      // Display styles
      displayLarge: GoogleFonts.montserrat(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: textHighEmphasis,
        letterSpacing: -0.5,
      ),
      displayMedium: GoogleFonts.montserrat(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
        letterSpacing: -0.25,
      ),
      displaySmall: GoogleFonts.montserrat(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
      ),

      // Headline styles
      headlineLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
      ),

      // Body styles
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: textHighEmphasis,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: textMediumEmphasis,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: textMediumEmphasis,
      ),

      // Label styles
      labelLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textMediumEmphasis,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textDisabled,
      ),

      // Title styles
      titleLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
      ),
    );
  }

  /// Helper method for pet status colors
  static Color getPetStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'available':
        return available500;
      case 'pending':
        return pending500;
      case 'sold':
        return sold500;
      default:
        return neutral500;
    }
  }

  /// Theme mode helper
  static ThemeMode getThemeMode(String mode) {
    switch (mode) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  /// Get semantic color based on type
  static Color getSemanticColor(String type, {bool isBackground = false}) {
    switch (type.toLowerCase()) {
      case 'success':
        return isBackground ? success100 : success600;
      case 'warning':
        return isBackground ? warning100 : warning600;
      case 'error':
        return isBackground ? error100 : error600;
      case 'info':
        return isBackground ? info100 : info600;
      default:
        return isBackground ? neutral100 : neutral600;
    }
  }
}
