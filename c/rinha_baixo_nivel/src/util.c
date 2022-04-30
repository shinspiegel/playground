#include <stdio.h>

//clean buffer
void getString(char string[]) {
    int c;
    while ((c = getchar()) != '\n' && c != EOF) { }
    scanf("%s", string);
}

//i dont know how to clean a buffer from integer yet :p
void getInteger(int *integer) {
    scanf("%i", integer);
}