#include <stdio.h>
#include <stdlib.h>

int get_int(char text[])
{
    int input, temp, status;

    puts(text);
    status = scanf("%d", &input);

    while (status != 1)
    {
        clean_input();
        printf("Invalid input... please enter a number: ");
        status = scanf("%d", &input);
    }

    clean_input();
    return input;
}

void clean_input()
{
    int temp;

    while ((temp = getchar()) != EOF && temp != '\n')
    {
    };
}