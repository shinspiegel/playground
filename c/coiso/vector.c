#include <stdio.h>
#include <stdlib.h>

int main(int argc, char const *argv[])
{
    for (int i = 0; i < 1000000; i++)
    {
        malloc(30);
    }
    
    return 0;
}
