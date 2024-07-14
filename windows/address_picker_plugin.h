#ifndef FLUTTER_PLUGIN_ADDRESS_PICKER_PLUGIN_H_
#define FLUTTER_PLUGIN_ADDRESS_PICKER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace address_picker_plugin {

class AddressPickerPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  AddressPickerPlugin();

  virtual ~AddressPickerPlugin();

  // Disallow copy and assign.
  AddressPickerPlugin(const AddressPickerPlugin&) = delete;
  AddressPickerPlugin& operator=(const AddressPickerPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace address_picker_plugin

#endif  // FLUTTER_PLUGIN_ADDRESS_PICKER_PLUGIN_H_
