import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'address_picker_plugin_method_channel.dart';

abstract class AddressPickerPluginPlatform extends PlatformInterface {
  /// Constructs a AddressPickerPluginPlatform.
  AddressPickerPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static AddressPickerPluginPlatform _instance = MethodChannelAddressPickerPlugin();

  /// The default instance of [AddressPickerPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelAddressPickerPlugin].
  static AddressPickerPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AddressPickerPluginPlatform] when
  /// they register themselves.
  static set instance(AddressPickerPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
