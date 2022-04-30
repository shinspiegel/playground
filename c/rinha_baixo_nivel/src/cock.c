#include "cock.h"
#include "random_number.h"
#include "messages.h"
#include "util.h"
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>
#include <unistd.h>

//introduce chicken by user
Cock CockbyUser()
{
    printf("Welcome to your galorkstation!\n");
    char name[10];
    int hpCock;
    int atkCock;
    int defCock;
    printf("Input your galo name (max 10 characters): ");
    getString(name);
    printf("%s is a great name! Now roll the dices for base stats\n Press 1 to run the D6 for the HP, ATK and DEF to your Galo\n Press 2 to cancel and return to menu\n Input option: ", name);
    int opt;
    getInteger(&opt);
    switch (opt)
    {
    case 1:
        hpCock = 10 + d6();
        atkCock = d6();
        defCock = d6();
        break;
    case 2:
        printf("See you soon\n");
        printf("returning to menu...\n");
        sleep(10);
        break;
    default:
        printf("Invalid parameter\n");
        exit(0);
        break;
    }
    printf("Galo created!!");
    if (hpCock <= 12)
    {
        galoBase(name[10], hpCock, atkCock, defCock);
    }

    printf("Do you want start a cocorifight or return to menu?\n 1- Start a cocorifight\n 2- Back to menu\n Enter your option: ");
    getInteger(&opt);
    if (opt == 1)
    {
        //fight function
    }
    else if (opt == 2)
    {
        //back to menu
    }
    else
    {
        printf("Invalid parameter\n");
        exit(0);
    }

    Cock cockuser = createNewCock(name, hpCock, atkCock, defCock);
    return cockuser;
}

Cock createNewCock(char name[], int hp, int atk, int def)
{
    Cock newCock;

    strcpy(newCock.name, name);
    newCock.max_hp = hp;
    newCock.hp = hp;
    newCock.atk = atk;
    newCock.def = def;

    return newCock;
}

void cockStatsOneLine(Cock *cock)
{
    printf("[%s] HP:%i/%i ATK:%i(%i) DEF:%i(%i)\n",
           cock->name,
           cock->hp,
           cock->max_hp,
           cock->atk,
           cock->hit,
           cock->def,
           cock->eva);
}

void introduceGalo(Cock *cock)
{
    printf("%s\n", cock->name);
    printf("HP: %i, ATK: %i, DEF: %i\n", cock->hp, cock->atk, cock->def);
    printf("********************\n");
}

int isCockAlive(Cock *cock)
{
    if (cock->hp > 0)
    {

        return true;
    }

    return false;
}
