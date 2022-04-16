#include <iostream>
#include <climits>

using std::cout;

int main()
{
    cout << sizeof(short) << std::endl;
    cout << sizeof(int) << std::endl;
    cout << sizeof(long) << std::endl;
    cout << sizeof(long long) << std::endl;

    cout << std::endl;

    cout << SHRT_MIN << " - " << SHRT_MAX << std::endl;
    cout << INT_MIN << " - " << INT_MAX << std::endl;
    cout << LONG_MIN << " - " << LONG_MAX << std::endl;
    cout << LLONG_MIN << " - " << LLONG_MAX << std::endl;

    cout << std::endl;

    cout << USHRT_MAX << std::endl;
    cout << UINT_MAX << std::endl;
    cout << ULONG_MAX << std::endl;
    cout << ULLONG_MAX << std::endl;
}
