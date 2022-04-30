#ifndef GALO
#define GALO

typedef struct Cock Cock;

struct Cock
{
    char name[10];
    int max_hp;
    int hp;
    int hit;
    int atk;
    int eva;
    int def;
};

Cock createNewCock(char name[], int hp, int atk, int def);

void introduceGalo(Cock *galo);

void galoAtk(Cock *attaker, Cock *defender);

void galoTakeDamage(Cock *galo, int damage);

void galoStatsOneLine(Cock *galo);

Cock CockbyUser();

int isCockAlive(Cock *cock);

#endif