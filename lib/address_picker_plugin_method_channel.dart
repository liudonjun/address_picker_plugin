import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'address_picker_plugin_platform_interface.dart';

/// An implementation of [AddressPickerPluginPlatform] that uses method channels.
class MethodChannelAddressPickerPlugin extends AddressPickerPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('address_picker_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
