#include <cstdlib>
#include <iostream>
#include <string>

/*
In this problem you will calculate how much money a person will have after investing for 10 years. 
They will invest $1000 each year.

Compounding interest is the act of reinvesting each years interest payment and then receiving 
interest on the initial value as well as on interest payments.

Your program will

1. Have the user enter their investment amount and expected interest 
  (Initial investment + additional added at end of each year)
2. Each year their investment will increase by their 
  investment + their investment * the interest rate
3. Print out their earnings after a 10 year period

Sample Output
How Much to Invest : 1000
Interest Rate : 10
Investment After 10 Years : 18531.17
*/

int main(int argc, char const *argv[])
{
  std::string input;
  int years, amount, rate;
  float interest = 0.0;
  float result = 0.0;

  std::cout << "How many years? ";
  std::cin >> input;
  years = stoi(input);

  std::cout << "How much to invest per year? ";
  std::cin >> input;
  amount = stoi(input);

  std::cout << "Invest rate? ";
  std::cin >> input;
  rate = stoi(input);

  interest = (float)rate * .01;

  for (int i = 0; i < years; i++)
  {
    result = result + (float)amount + (result * interest);
  }

  printf("Investment after %d years: %.2f\n", years, result);

  return 0;
}
