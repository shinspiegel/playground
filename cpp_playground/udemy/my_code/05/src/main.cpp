#include <cstdlib>
#include <iostream>
#include <string>
#include <limits>
using namespace std;

int main(int argc, char const *argv[])
{
  cout << "Min bool " << numeric_limits<bool>::min() << endl;
  cout << "Max bool " << numeric_limits<bool>::max() << endl;

  cout << "Min unsigned short int " << numeric_limits<unsigned short int>::min() << endl;
  cout << "Max unsigned short int " << numeric_limits<unsigned short int>::max() << endl;

  cout << "Min short int " << numeric_limits<short int>::min() << endl;
  cout << "Max short int " << numeric_limits<short int>::max() << endl;

  cout << "Min int " << numeric_limits<int>::min() << endl;
  cout << "Max int " << numeric_limits<int>::max() << endl;

  cout << "Min long " << numeric_limits<long int>::min() << endl;
  cout << "Max long " << numeric_limits<long int>::max() << endl;

  cout << "Min float " << numeric_limits<float>::min() << endl;
  cout << "Max float " << numeric_limits<float>::max() << endl;

  cout << "Min long double " << numeric_limits<long double>::min() << endl;
  cout << "Max long double " << numeric_limits<long double>::max() << endl;
  return 0;
}
