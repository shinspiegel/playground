#include <stdlib.h>
#include <time.h>

int random_number_between(int min, int max)
{
    srand(time(0));
    return (rand() % (max - min + 1)) + min;
};

int d2()
{
    return random_number_between(1, 2);
};

int d4()
{
    return random_number_between(1, 4);
};

int d6()
{
    return random_number_between(1, 6);
}

int d8()
{
    return random_number_between(1, 8);
};

int d10()
{
    return random_number_between(1, 10);
};

int d12()
{
    return random_number_between(1, 12);
};

int d20()
{
    return random_number_between(1, 20);
};

int d100()
{
    return random_number_between(1, 100);
};