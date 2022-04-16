#include <cstdlib>
#include <iostream>
#include <string>

/*
You'll write a program that will ask the user for their age. 
If they are less than 5 tell them they are too young. 
If they are 5 send them to Kindergarten. 
If they are between 5 and 17 calculate their grade. 
If over 18 send them to college.

Here is sample output for this program

Enter age : 13

Go to grade 8
*/

int main(int argc, char const *argv[])
{
  std::cout << "Please, provide an age: ";

  std::string string_value;
  std::cin >> string_value;

  int value = std::stoi(string_value);

  if (value <= 5)
  {
    std::cout << "Go to kindergarten";
  }
  else if (value <= 17)
  {
    std::cout << "Go to grade " << (value - 5);
  }
  else if (value >= 18)
  {
    std::cout << "Go to collage";
  }

  std::cout << std::endl;

  return 0;
}
