#include <stdio.h>

int main()
{
  int type = 0;
  int quantity = 0;
  float total = 0;

  printf("What is the type: ");
  scanf("%d", &type);

  if (type == 1)
  {
    printf("How many?: ");
    scanf("%d", &quantity);
    total = (float)quantity * 3.5;
  }

  if (type == 2)
  {
    printf("How many?: ");
    scanf("%d", &quantity);
    total = (float)quantity * 5.5f;
  }

  printf("The total is: %.2f\n", total);
  return 0;
}