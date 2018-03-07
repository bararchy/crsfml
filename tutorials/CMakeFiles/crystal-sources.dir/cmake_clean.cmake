file(REMOVE_RECURSE
  "CMakeFiles/crystal-sources"
  "voidcsfml/include/voidcsfml/system.h"
  "voidcsfml/src/voidcsfml/system.cpp"
  "voidcsfml/include/voidcsfml/window.h"
  "voidcsfml/src/voidcsfml/window.cpp"
  "voidcsfml/include/voidcsfml/graphics.h"
  "voidcsfml/src/voidcsfml/graphics.cpp"
  "voidcsfml/include/voidcsfml/audio.h"
  "voidcsfml/src/voidcsfml/audio.cpp"
  "voidcsfml/include/voidcsfml/network.h"
  "voidcsfml/src/voidcsfml/network.cpp"
  "src/system/lib.cr"
  "src/system/obj.cr"
  "src/window/lib.cr"
  "src/window/obj.cr"
  "src/graphics/lib.cr"
  "src/graphics/obj.cr"
  "src/audio/lib.cr"
  "src/audio/obj.cr"
  "src/network/lib.cr"
  "src/network/obj.cr"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/crystal-sources.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
