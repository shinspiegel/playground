#include <stdio.h>
#include <string.h>

typedef struct Diamond
{
  char mine[1000];

} Diamond;

int main(int argc, char const *argv[])
{
  int amount = 0;
  scanf("%d", &amount);
  fflush(stdin);

  Diamond diamond_list[1000];
  int diamont_result[1000];

  for (int i = 0; i < amount; i++)
  {
    char string[1000];
    fgets(string, 1000, stdin);

    Diamond item;
    strcpy(item.mine, string);

    diamond_list[i] = item;
  }

  for (int i = 0; i < amount; i++)
  {
    int left = 0;
    int right = 0;

    for (int j = 0; j < 1000; j++)
    {
      if (diamond_list[i].mine[j] == '<')
      {
        left += 1;
      }
      if (diamond_list[i].mine[j] == '>')
      {
        right += 1;
      }
    }

    if (left == right)
    {
      diamont_result[i] = left;
    }

    if (left < right)
    {
      diamont_result[i] = left;
    }

    if (right < left)
    {
      diamont_result[i] = right;
    }
  }

  for (int i = 0; i < amount; i++)
  {
    printf("%d\n", diamont_result[i]);
  }

  printf("\n");

  return 0;
}
