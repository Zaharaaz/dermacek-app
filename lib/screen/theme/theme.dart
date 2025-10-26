import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff5b631e),
      surfaceTint: Color(0xff5b631e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffe0e994),
      onPrimaryContainer: Color(0xff444b05),
      secondary: Color(0xff5e6144),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffe3e5c1),
      onSecondaryContainer: Color(0xff46492e),
      tertiary: Color(0xff3b665a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffbeecdd),
      onTertiaryContainer: Color(0xff234e43),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffcfaed),
      onSurface: Color(0xff1c1c14),
      onSurfaceVariant: Color(0xff47483b),
      outline: Color(0xff78786a),
      outlineVariant: Color(0xffc8c7b7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313128),
      inversePrimary: Color(0xffc4cd7b),
      primaryFixed: Color(0xffe0e994),
      onPrimaryFixed: Color(0xff1a1e00),
      primaryFixedDim: Color(0xffc4cd7b),
      onPrimaryFixedVariant: Color(0xff444b05),
      secondaryFixed: Color(0xffe3e5c1),
      onSecondaryFixed: Color(0xff1b1d07),
      secondaryFixedDim: Color(0xffc7c9a7),
      onSecondaryFixedVariant: Color(0xff46492e),
      tertiaryFixed: Color(0xffbeecdd),
      onTertiaryFixed: Color(0xff002019),
      tertiaryFixedDim: Color(0xffa2d0c1),
      onTertiaryFixedVariant: Color(0xff234e43),
      surfaceDim: Color(0xffdcdace),
      surfaceBright: Color(0xfffcfaed),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f4e7),
      surfaceContainer: Color(0xfff0eee1),
      surfaceContainerHigh: Color(0xffeae9dc),
      surfaceContainerHighest: Color(0xffe5e3d6),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff333a00),
      surfaceTint: Color(0xff5b631e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff6a722b),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff35381f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6d6f52),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff0f3d33),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff4a7569),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcfaed),
      onSurface: Color(0xff11120a),
      onSurfaceVariant: Color(0xff36372b),
      outline: Color(0xff535346),
      outlineVariant: Color(0xff6e6e60),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313128),
      inversePrimary: Color(0xffc4cd7b),
      primaryFixed: Color(0xff6a722b),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff525914),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff6d6f52),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff54573b),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff4a7569),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff315d51),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc8c7bb),
      surfaceBright: Color(0xfffcfaed),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f4e7),
      surfaceContainer: Color(0xffeae9dc),
      surfaceContainerHigh: Color(0xffdfddd1),
      surfaceContainerHighest: Color(0xffd4d2c6),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff2a2f00),
      surfaceTint: Color(0xff5b631e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff464d07),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2b2e16),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff484b31),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff013329),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff255146),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcfaed),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff2c2d22),
      outlineVariant: Color(0xff494a3d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313128),
      inversePrimary: Color(0xffc4cd7b),
      primaryFixed: Color(0xff464d07),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff303600),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff484b31),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff32351c),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff255146),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff0a3a2f),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbab9ad),
      surfaceBright: Color(0xfffcfaed),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f1e4),
      surfaceContainer: Color(0xffe5e3d6),
      surfaceContainerHigh: Color(0xffd6d5c8),
      surfaceContainerHighest: Color(0xffc8c7bb),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc4cd7b),
      surfaceTint: Color(0xffc4cd7b),
      onPrimary: Color(0xff2e3300),
      primaryContainer: Color(0xff444b05),
      onPrimaryContainer: Color(0xffe0e994),
      secondary: Color(0xffc7c9a7),
      onSecondary: Color(0xff2f321a),
      secondaryContainer: Color(0xff46492e),
      onSecondaryContainer: Color(0xffe3e5c1),
      tertiary: Color(0xffa2d0c1),
      onTertiary: Color(0xff06372d),
      tertiaryContainer: Color(0xff234e43),
      onTertiaryContainer: Color(0xffbeecdd),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff13140d),
      onSurface: Color(0xffe5e3d6),
      onSurfaceVariant: Color(0xffc8c7b7),
      outline: Color(0xff929282),
      outlineVariant: Color(0xff47483b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e3d6),
      inversePrimary: Color(0xff5b631e),
      primaryFixed: Color(0xffe0e994),
      onPrimaryFixed: Color(0xff1a1e00),
      primaryFixedDim: Color(0xffc4cd7b),
      onPrimaryFixedVariant: Color(0xff444b05),
      secondaryFixed: Color(0xffe3e5c1),
      onSecondaryFixed: Color(0xff1b1d07),
      secondaryFixedDim: Color(0xffc7c9a7),
      onSecondaryFixedVariant: Color(0xff46492e),
      tertiaryFixed: Color(0xffbeecdd),
      onTertiaryFixed: Color(0xff002019),
      tertiaryFixedDim: Color(0xffa2d0c1),
      onTertiaryFixedVariant: Color(0xff234e43),
      surfaceDim: Color(0xff13140d),
      surfaceBright: Color(0xff393a31),
      surfaceContainerLowest: Color(0xff0e0f08),
      surfaceContainerLow: Color(0xff1c1c14),
      surfaceContainer: Color(0xff202018),
      surfaceContainerHigh: Color(0xff2a2b22),
      surfaceContainerHighest: Color(0xff35352d),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffd9e38f),
      surfaceTint: Color(0xffc4cd7b),
      onPrimary: Color(0xff242800),
      primaryContainer: Color(0xff8e964b),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffdddfbb),
      onSecondary: Color(0xff252710),
      secondaryContainer: Color(0xff909374),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffb8e6d7),
      onTertiary: Color(0xff002c23),
      tertiaryContainer: Color(0xff6d9a8c),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff13140d),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffdeddcc),
      outline: Color(0xffb3b3a3),
      outlineVariant: Color(0xff919182),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e3d6),
      inversePrimary: Color(0xff454c06),
      primaryFixed: Color(0xffe0e994),
      onPrimaryFixed: Color(0xff101300),
      primaryFixedDim: Color(0xffc4cd7b),
      onPrimaryFixedVariant: Color(0xff333a00),
      secondaryFixed: Color(0xffe3e5c1),
      onSecondaryFixed: Color(0xff101301),
      secondaryFixedDim: Color(0xffc7c9a7),
      onSecondaryFixedVariant: Color(0xff35381f),
      tertiaryFixed: Color(0xffbeecdd),
      onTertiaryFixed: Color(0xff00150f),
      tertiaryFixedDim: Color(0xffa2d0c1),
      onTertiaryFixedVariant: Color(0xff0f3d33),
      surfaceDim: Color(0xff13140d),
      surfaceBright: Color(0xff45453c),
      surfaceContainerLowest: Color(0xff070803),
      surfaceContainerLow: Color(0xff1e1e16),
      surfaceContainer: Color(0xff282820),
      surfaceContainerHigh: Color(0xff33332b),
      surfaceContainerHighest: Color(0xff3e3e35),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffedf7a1),
      surfaceTint: Color(0xffc4cd7b),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffc0c978),
      onPrimaryContainer: Color(0xff0a0c00),
      secondary: Color(0xfff1f3ce),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffc3c5a3),
      onSecondaryContainer: Color(0xff0a0c00),
      tertiary: Color(0xffcbfaea),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff9eccbd),
      onTertiaryContainer: Color(0xff000e0a),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff13140d),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfff2f1df),
      outlineVariant: Color(0xffc4c3b3),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e3d6),
      inversePrimary: Color(0xff454c06),
      primaryFixed: Color(0xffe0e994),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffc4cd7b),
      onPrimaryFixedVariant: Color(0xff101300),
      secondaryFixed: Color(0xffe3e5c1),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffc7c9a7),
      onSecondaryFixedVariant: Color(0xff101301),
      tertiaryFixed: Color(0xffbeecdd),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffa2d0c1),
      onTertiaryFixedVariant: Color(0xff00150f),
      surfaceDim: Color(0xff13140d),
      surfaceBright: Color(0xff515147),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff202018),
      surfaceContainer: Color(0xff313128),
      surfaceContainerHigh: Color(0xff3c3c33),
      surfaceContainerHighest: Color(0xff47473e),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
