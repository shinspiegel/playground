#include <iostream>
#include <cstdlib>
#include <string>
#include <cmath>
#include <ctime>

using namespace std;

int main()
{
  srand(time(NULL));
  int secretNum = rand() % 11;

  int guess = 0;
  int count = 0;

  while (guess != secretNum)
  {
    cout << "Guess a number: ";
    cin >> guess;
    count++;

    if (guess > secretNum)
    {
      cout << "Too high!" << endl;
    }

    if (guess < secretNum)
    {
      cout << "Too low!" << endl;
    }
  }

  cout << "You did right!" << endl;
  printf("You took %d guesses to get the right one\n", count);

  return 0;
}
