#include <iostream>
#include <cstdlib>
#include <string>
#include <cmath>
#include <ctime>

using namespace std;

int main(){

    // Another thing every programming language must do is to provide a way to 
    // perform the same action multiple times. The keyword for is one one way in 
    // which you can loop through code while executing repeatedly.

    // For as long as you have more hamburger to eat, keep eating that hamburger.
    // For loops come in many forms.

    // Cycle through each value and print it
    for(int i = 0; i <= 10; ++i){
        cout << i << endl;
    }

    // You can cycle through arrays which are lists of values
    int arr1[] = {1,2,3};
    // We have to calculate the array size by providing a sample
    // of the type of data it takes up
    int arrSize = sizeof(arr1)/sizeof(arr1[0]);
    for(int i = 0; i < arrSize; ++i){
        cout << arr1[i] << endl;
    }

    // An abbreviated for loop
    for(auto x: arr1) cout << x << endl;

    // PROBLEM
    // Now before you solve a problem I want to teach you how to test if a number 
    // is odd or even. If you divide any even number by 2 it will not have a 
    // remainder. The modulus operator provides the remainder of a division as 
    // I covered previously.

    // So if num % 2 == 0 we know that num is an even value.
    int num = 4;
    string isEven = ((num % 2) == 0) ? "Even" : "Odd";
    cout << "Even or Odd : " << isEven << "\n";

    // Use the knowledge you have gained to print out all odd numbers from 1 to 20. 
    // Feel free to look at everything on this page to help

    // SOLUTION
    for(int i = 0; i <= 20; ++i){
        if((i % 2) != 0){
            cout << i << endl;
        }
    }

    // PROBLEM
    // In this problem you will calculate how much money a person will have after 
    // investing for 10 years. Compounding interest is the act of reinvesting each years 
    // interest payment and then receiving interest on the initial value as well as on 
    // interest payments.

    // Your program will : 
    // 1. Have the user enter their investment amount and expected interest (Initial investment + additional added at end of each year)
    // 2. Each year their investment will increase by their investment + their investment
    // * the interest rate
    // 3. Print out their earnings after a 10 year period

    float investment, interest, total;

    cout << "How Much to Invest : ";
    cin >> investment;
    total = investment;
    cout << "Interest Rate : ";
    cin >> interest;
    interest = interest * .01;
    for(int i = 0; i < 10; ++i){
        total = total + investment + (total * interest);
    }
    printf("Investment After 10 Years : %.2f\n", total);

    return 0;
}
