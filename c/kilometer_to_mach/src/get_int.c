#include <stdio.h>

int get_int(char text[])
{
  int input, temp, status;

  puts(text);
  status = scanf("%d", &input);

  while (status != 1)
  {
    while ((temp = getchar()) != EOF && temp != '\n')
      ;

    printf("Invalid input... please enter a number: ");
    status = scanf("%d", &input);
  }

  return input;
}