#pragma once
#include <string>
namespace gcb {
struct Options { int device=0; int iterations=20; int suite=0; std::string csv="results.csv"; };
void run(const Options& options);
}
