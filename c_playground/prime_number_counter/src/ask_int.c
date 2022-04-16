#include <stdio.h>

int ask_int()
{
  int n = 0;
  printf("Type a number: ");
  scanf("%d", &n);

  return n;
}