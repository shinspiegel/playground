#include "cock.h"
#include "random_number.h"
#include <stdbool.h>

/**
 * This function will make a combat turn between two cocks
 */
void combatTurn(Cock *cock1, Cock *cock2)
{
    /**
     * This will create two values for both cocks.
     * The cock with higher speed will attack first.
     * If a hit make a cock below 0 hp, the function will ends.
     * If both cocks have the same speed they will hit at the same time.
     */
    int cock1Speed = d20();
    int cock2Speed = d20();

    if (cock1Speed > cock2Speed)
    {
        cockAtk(cock1, cock2);
        if (!isCockAlive(cock2))
        {
            return;
        }

        cockAtk(cock2, cock1);
    }

    if (cock1Speed < cock2Speed)
    {
        cockAtk(cock2, cock1);
        if (!isCockAlive(cock1))
        {
            return;
        }

        cockAtk(cock1, cock2);
    }

    if (cock1Speed = cock2Speed)
    {
        cockAtk(cock2, cock1);
        cockAtk(cock1, cock2);
    }
}

/**
 * This is a cock attaking another cock.
 * When attacking will make a "Hit - Evasion", this will create a value between 1 and 100.
 * After this if the random number is below or equal this threshoud it will hit the target.
 */
void cockAtk(Cock *attaker, Cock *defender)
{
    int hitPower = attaker->hit - defender->eva;
    int hitValue = d100();

    if (hitPower > 100)
    {
        hitPower = 100;
    }

    if (hitPower < 1)
    {
        hitPower = 1;
    }

    if (hitValue <= hitPower)
    {
        printf("%s acertou o %s!\n", attaker->name, defender->name);
        cockTakeDamage(defender, attaker->atk);
    }
    else
    {
        printf("%s se esquivou bem!\n", defender->name);
    }
};

/**
 * This will make a cock receive a damage.
 * The amount of damage will be reduced from the cock.
 * If the damage is negative it will be zero.
 */
void cockTakeDamage(Cock *galo, int damage)
{
    if (damage < 0)
    {
        damage = 1;
    }

    galo->hp = galo->hp - damage;
};