#include <stdio.h>
#include "ask_int.h"
#include "is_prime.h"

void loop_through(int, int);

int main()
{
  int first = 0;
  int second = 0;

  first = ask_int();
  second = ask_int();

  loop_through(first, second);

  return 0;
}

void loop_through(int start, int end)
{
  for (size_t i = start; i < end; i++)
  {
    if (is_prime(i))
    {
      printf("%ld \t", i);
    }
  }

  printf("\n");
}