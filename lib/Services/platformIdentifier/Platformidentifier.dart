import 'package:universal_platform/universal_platform.dart';

/// check the platform
final bool isWeb = UniversalPlatform.isWeb;
final bool isMacOS = UniversalPlatform.isMacOS;
final bool isWindow = UniversalPlatform.isWindows;
final bool isIos = UniversalPlatform.isIOS;
final bool isMobile = UniversalPlatform.isIOS || UniversalPlatform.isAndroid;
final bool isAndroid = UniversalPlatform.isAndroid;
final bool isFuchsia = UniversalPlatform.isFuchsia;
