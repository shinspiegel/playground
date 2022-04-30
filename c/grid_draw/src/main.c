#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void fill_matrix(int size, int matrix[size][size]);
void update_matrix(int min, int max, int size, int matrix[size][size]);
void draw_matrix(int size, int matrix[size][size]);

int main(int argc, char const *argv[])
{
    int amount = strtonum(argv[1], 0, 100, NULL);
    int matrix[amount][amount];

    fill_matrix(amount, matrix);
    update_matrix(0, amount, amount, matrix);
    draw_matrix(amount, matrix);

    return 0;
}

void fill_matrix(int size, int matrix[size][size])
{
    for (int i = 0; i < size; i++)
    {
        for (int j = 0; j < size; j++)
        {
            matrix[i][j] = 0;
        }
    }
}

void update_matrix(int min, int max, int size, int matrix[size][size])
{
    if (min > max)
    {
        return;
    }

    for (int i = min; i < max; i++)
    {
        for (int j = min; j < max; j++)
        {
            matrix[i][j] += 1;
        }
    }

    update_matrix(min + 1, max - 1, size, matrix);
}

void draw_matrix(int size, int matrix[size][size])
{
    for (int i = 0; i < size; i++)
    {
        for (int j = 0; j < size; j++)
        {
            int value = matrix[i][j];
            printf("%d ", value);
        }
        printf("\n");
    }
}
