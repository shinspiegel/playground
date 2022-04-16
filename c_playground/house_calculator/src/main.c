#include <stdio.h>
#include <string.h>
#include "get_variables.h"

struct Room
{
    char name[30];
    int width;
    int deep;
};

void ask_loop(struct Room list[], int size);
void print_loop(struct Room list[], int size);

int main(int argc, char const *argv[])
{
    int qty = get_int("How many rooms?");
    struct Room room_list[qty];

    ask_loop(room_list, qty);
    print_loop(room_list, qty);

    return 0;
}

void ask_loop(struct Room list[], int size)
{
    for (size_t i = 0; i < size; i++)
    {
        printf("This is the room number %ld \n", i + 1);

        printf("Enter name: ");
        scanf("%[^\t\n]", list[i].name);
        clean_input();

        list[i].width = get_int("Type the width?");
        list[i].deep = get_int("Type the deep?");
    }
}

void print_loop(struct Room list[], int size)
{
    int total = 0;
    printf("There is %d rooms.\n", size);

    for (size_t i = 0; i < size; i++)
    {
        int w = list[i].width;
        int z = list[i].deep;

        total += (w * z);

        printf("%ld.[%s]: %dx%d (%d) \n",
               i + 1,
               list[i].name,
               w,
               z,
               w * z);
    }

    printf("Total area of the house is: %d.\n", total);
}