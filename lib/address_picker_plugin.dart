
import 'address_picker_plugin_platform_interface.dart';

class AddressPickerPlugin {
  Future<String?> getPlatformVersion() {
    return AddressPickerPluginPlatform.instance.getPlatformVersion();
  }
}
