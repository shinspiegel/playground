#include <iostream>

using std::cin;
using std::cout;
using std::string;

double my_pow(double, int);
void print_pow(double, int);

int main()
{
    string test = "Shin";
    int base = 0;
    int exponent = 0;

    printf("Base value: ");
    cin >> base;
    printf("Exponent: ");
    cin >> exponent;

    print_pow(base, exponent);
}

void print_pow(double base, int exponent)
{
    cout << "The result of base " << base << " at the power of " << exponent;
    cout << " is: " << my_pow(base, exponent) << std::endl;
}

double my_pow(double base, int exponent)
{
    double result = 1;

    for (int i = 0; i < exponent - 1; i++)
    {
        result = result * base;
    }

    return result;
}