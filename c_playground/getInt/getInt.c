#include <stdio.h>

int getInt(const char *message)
{
    int value;
    printf("%s", message);
    scanf("%d", &value);
    return value;
}

int main(int argc, char const *argv[])
{
    int test;

    test = getInt("Please inform a message");
    printf("Number was: %d", test);

    return 0;
}
