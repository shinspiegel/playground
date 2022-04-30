#include <iostream>
#include <climits>

using std::cout;

int main()
{
    char x = 'b';

    cout << sizeof(char) << std::endl;
    cout << CHAR_MIN << " - " << CHAR_MAX << std::endl;
    cout << UCHAR_MAX << std::endl;
}
