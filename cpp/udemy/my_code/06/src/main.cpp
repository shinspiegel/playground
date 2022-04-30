#include <cstdlib>
#include <iostream>
#include <string>

using namespace std;

int main(int argc, char const *argv[])
{
  string string_value;
  cout << "Enter miles: ";
  cin >> string_value;

  int value = stoi(string_value);
  float result = (float)value * 1.609344;

  printf("%d miles equals %.3f kilometers\n", value, result);

  return 0;
}
