#include <stdio.h>
#include <stdlib.h>

#define TAM 20

struct book
{
    int code;
    char title[50];
    char author[30];
    char subject[20];
    int year;
    char publisher[20];
};

int main()
{
    struct book book_shelf[TAM];
    struct book book_switch;

    return 0;
}
