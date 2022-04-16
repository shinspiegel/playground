#include <stdio.h>
#include "get_int.h"

int get_int(char str[]);

int main(int argc, char const *argv[])
{
  int speed = get_int("Type the speed in km/h: ");
  double speed_in_ms = (double)speed / 3.6;
  double mach_speed = speed_in_ms / 343.0;

  printf("Value %.2f \n", mach_speed);

  return 0;
}