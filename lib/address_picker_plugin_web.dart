// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show window;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'address_picker_plugin_platform_interface.dart';

/// A web implementation of the AddressPickerPluginPlatform of the AddressPickerPlugin plugin.
class AddressPickerPluginWeb extends AddressPickerPluginPlatform {
  /// Constructs a AddressPickerPluginWeb
  AddressPickerPluginWeb();

  static void registerWith(Registrar registrar) {
    AddressPickerPluginPlatform.instance = AddressPickerPluginWeb();
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String?> getPlatformVersion() async {
    final version = html.window.navigator.userAgent;
    return version;
  }
}
