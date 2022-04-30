#include <iostream>
#include <cmath>

using std::cin;
using std::cout;

int main()
{
    int base = 0;
    int exponent = 0;

    printf("Base value: ");
    cin >> base;
    printf("Exponent: ");
    cin >> exponent;

    cout << pow(base, exponent) << std::endl;
}
