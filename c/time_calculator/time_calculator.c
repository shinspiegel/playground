#include <stdio.h>

int main()
{
  int time = 8;
  int hour_value = 60;
  float valid_partial = 0.8;

  int total_minutes = time * hour_value;

  int minutes_left = (float)total_minutes * valid_partial;

  float hours_left = (float)minutes_left / (float)hour_value;

  printf("Total minutes is: %d.\n", total_minutes);
  printf("Total minutes left is: %d.\n", minutes_left);
  printf("Total hours left is: %f.\n", hours_left);
  return 0;
}