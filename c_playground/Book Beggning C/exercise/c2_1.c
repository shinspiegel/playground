#include <stdio.h>

int main()
{
  float value = 0;

  printf("Please insert distance in inches: ");
  scanf("%f", &value);
  printf("\n");

  printf("The total in cm is: %f\n", value * 2.54);
}