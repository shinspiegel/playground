#include <stdio.h>
#include <stdbool.h>

bool is_prime(int v)
{
  if (v == 1 || v == 2)
  {
    return true;
  }

  for (size_t i = 2; i < v; i++)
  {
    if ((int)v % (int)i == 0)
    {
      return false;
    }
  }

  return true;
}
