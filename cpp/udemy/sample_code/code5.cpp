#include <iostream>
#include <cstdlib>
#include <string>
#include <cmath>
#include <ctime>

using namespace std;

int main(){

    // There are numerous math functions provided by
    // cmath en.cppreference.com/w/cpp/numeric/math
 
    cout << "abs(-10) = " << abs(-10) << endl;
    cout << "max(5, 4) = " << max(5, 4) << endl;
    cout << "min(5, 4) = " << min(5, 4) << endl;
    cout << "fmax(5.3, 4.3) = " << fmax(5.3, 4.3) << endl;
    cout << "fmin(5.3, 4.3) = " << fmin(5.3, 4.3) << endl;
    cout << "ceil(10.45) = " << ceil(10.45) << endl;
    cout << "floor(10.45) = " << floor(10.45) << endl;
    cout << "round(10.45) = " << round(10.45) << endl;
    cout << "pow(2,3) = " << pow(2,3) << endl;
    cout << "sqrt(100) = " << sqrt(100) << endl;
    cout << "cbrt(1000) = " << cbrt(1000) << endl;
 
    // e ^ x
    cout << "exp(1) = " << exp(1) << endl;
 
    // 2 ^ x
    cout << "exp2(1) = " << exp2(1) << endl;
 
    // e * e * e ~= 20 so log(20.079) ~= 3
    cout << "log(20.079) = " << log(20.079) << endl;
 
    // 2 * 2 * 2 = 8
    cout << "log2(8) = " << log2(8) << endl;
 
    // Hypotenuse : SQRT(A^2 + B^2)
    cout << "hypot(2,3) = " << hypot(2,3) << endl;
 
    // Also sin, cos, tan, asin, acos, atan, atan2,
    // sinh, cosh, tanh, asinh, acosh, atanh

    // We need to seed the random number generator
    // time() returns the number of seconds
    // since 1, 1, 1970
    // #include <ctime>
    srand(time(NULL));
 
    // Generate a random number up to 10
    int secretNum = rand() % 11;
    cout << "Secret Number : " << secretNum << "\n";

}
