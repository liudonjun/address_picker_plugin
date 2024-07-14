import 'package:flutter_test/flutter_test.dart';
import 'package:address_picker_plugin/address_picker_plugin.dart';
import 'package:address_picker_plugin/address_picker_plugin_platform_interface.dart';
import 'package:address_picker_plugin/address_picker_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAddressPickerPluginPlatform
    with MockPlatformInterfaceMixin
    implements AddressPickerPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AddressPickerPluginPlatform initialPlatform = AddressPickerPluginPlatform.instance;

  test('$MethodChannelAddressPickerPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAddressPickerPlugin>());
  });

  test('getPlatformVersion', () async {
    AddressPickerPlugin addressPickerPlugin = AddressPickerPlugin();
    MockAddressPickerPluginPlatform fakePlatform = MockAddressPickerPluginPlatform();
    AddressPickerPluginPlatform.instance = fakePlatform;

    expect(await addressPickerPlugin.getPlatformVersion(), '42');
  });
}
