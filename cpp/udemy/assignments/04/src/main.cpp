#include <cstdlib>
#include <iostream>
#include <string>

/*
How tall is the tree : 5
5
    #    |  4  1  4  = 9 
   ###   |  3  3  3  = 9 
  #####  |  2  5  2  = 9 
 ####### |  1  7  1  = 9  
#########|  0  9  0  = 9 
    #    |  4  1  4  = - 

4
   #     |  3  1  3  = 7 
  ###    |  2  3  2  = 9 
 #####   |  1  5  1  = 9 
#######  |  0  7  0  = 9  
   #     |  4  1  4  = - 


*/

void print_line_tree(int left, int hash, int right);

int main(int argc, char const *argv[])
{
  int height = 0;
  int total = 0;

  std::cout << "How tall? ";
  std::cin >> height;

  total = (height * 2) - 1;

  for (int i = 1; i <= height; i++)
  {
    int side = height - i;
    int middle = total - (side * 2);

    print_line_tree(side, middle, side);
    printf("\n");
  }

  print_line_tree(height - 1, 1, height - 1);
  printf("\n");

  return 0;
}

void print_line_tree(int left, int hash, int right)
{
  for (int i = 0; i < left; i++)
  {
    printf(" ");
  }

  for (int i = 0; i < hash; i++)
  {
    printf("#");
  }

  for (int i = 0; i < right; i++)
  {
    printf(" ");
  }
}