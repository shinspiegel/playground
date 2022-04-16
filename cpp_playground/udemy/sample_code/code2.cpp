#include <cstdlib>
#include <iostream>
// Allows you to use the STL string class
#include <string>

// Provides functions to find min and max values
// for data types
#include <limits>

using namespace std;

// When we create a variable we are telling the computer
// how much memory to set aside for its value and what
// name we want to associate with that data

// Variable names can contain letters, numbers, underscores
// but not math operators, spaces and can't start with a number

// Global variables are declared outside of any functions
// and can be accessed any where in the code
// This is a global integer variable with a name using
// Hungarian notation
int g_iRandNum = 0;

// const defines constant values that won't change
const double PI = 3.1415926535897932;

int main()
{
  // bools store true 1, or false 0
  bool bMarried = true;

  // char stores 256 single characters represented by your keyboard
  char chMyGrade = 'A';

  // unsigned short ints hold values from 0 to 65,535
  // unsigned int & unsigned long int double their max value
  unsigned short int u16Age = 43;

  // short ints store between -32,768 to 32,767
  short int siWeight = 180;

  // ints range from -2147483648 to 2147483647
  int nDays = 7;

  // long ints and long long ints range from -9223372036854775808 to
  // 9223372036854775807
  long lBigNum = 1000000;

  // floats range from 1.17549e-38 to 3.40282e+38
  float fPi = 3.14159;

  // Show float precision
  float fBigFloat = 1.1111111111;
  float fBigFloat2 = 1.1111111111;
  float fFloatSum = fBigFloat + fBigFloat2;

  // Allows you to print with formatting
  // Float addition has 6 digits of precision
  printf("fFloatSum Precision : %.10f\n", fFloatSum);

  // doubles range from 2.22507e-308 to 1.79769e+308

  cout << "Min double " << numeric_limits<double>::min() << endl;
  cout << "Max double " << numeric_limits<double>::max() << endl;

  // Show double precision
  double dbBigFloat = 1.11111111111111111111;
  double dbBigFloat2 = 1.11111111111111111111;
  double dbFloatSum = dbBigFloat + dbBigFloat2;

  // Allows you to print with formatting
  // Double addition has 15 digits of precision
  printf("dbFloatSum Precision : %.20f\n", dbFloatSum);

  // long doubles range from 3.3621e-4932 to 1.18973e+4932
  long double ldPi = 3.1415926535897932;

  // You can have the compiler assign a type
  auto whatWillIBe = true;

  // SHOW DATA TYPES MIN & MAX VALUES

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

  // Get the number of bytes used by a type
  cout << "int Size " << sizeof(int) << endl;

  // More about printf()
  // char, int, 5 space right justified int,
  // 3 decimal float / double, string specifiers
  printf("%c %d %5d %.3f %s\n", 'A', 10, 5, 3.1234, "Hi");

  return 0;
}
