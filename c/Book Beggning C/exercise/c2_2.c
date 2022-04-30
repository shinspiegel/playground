#include <stdio.h>

int main()
{
  int length = 0;
  int side = 0;

  printf("Please insert the distance length of the room: ");
  scanf("%d", &length);
  printf("Please insert the distance side of the room: ");
  scanf("%d", &side);

  printf("The total area in cubic meters is: %f\n", ((float)length * (float)side) / 10000);
}