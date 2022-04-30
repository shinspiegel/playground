#include <cstdlib>
#include <iostream>
#include <string>

/*
Use the knowledge you have gained to print out all odd numbers from 1 to 20. 
Feel free to look at everything aside from the answer.
*/

int main(int argc, char const *argv[])
{
  for (int i = 0; i < 20; i++)
  {
    if (i % 2 != 0)
    {
      std::cout << i << std::endl;
    }
  }

  return 0;
}
a