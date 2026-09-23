#include "raindrops.h"
#include <string>

namespace raindrops {

std::string convert(int n) {
  std::string result = "";

  if (n % 3 == 0)
    result.append("Pling");
  if (n % 5 == 0)
    result.append("Plang");
  if (n % 7 == 0)
    result.append("Plong");

  if (result.length() == 0)
    return std::to_string(n);

  return result;
}

} // namespace raindrops
