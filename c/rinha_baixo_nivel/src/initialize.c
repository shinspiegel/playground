#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include "messages.h"
#include "cock.h"

void initialize()
{
    char receive;
    printf("Want to start?: [Y/N] ");
    receive = fgetc(stdin);
    if (isalpha(receive))
    {
        receive = tolower(receive);
    }

    switch (receive)
    {
    case 'y':
        showTitle();
        CockbyUser();
        break;
    case 'n':
        exit(0);
        break;
    default:
        printf("Smart cock go to school bruh :/\n");
        printf("invalid parameter\n");
        exit(0);
        break;
    }
}