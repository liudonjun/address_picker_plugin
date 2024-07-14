//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <address_picker_plugin/address_picker_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) address_picker_plugin_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "AddressPickerPlugin");
  address_picker_plugin_register_with_registrar(address_picker_plugin_registrar);
}
