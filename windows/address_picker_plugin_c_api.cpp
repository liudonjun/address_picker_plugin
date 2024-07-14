#include "include/address_picker_plugin/address_picker_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "address_picker_plugin.h"

void AddressPickerPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  address_picker_plugin::AddressPickerPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
