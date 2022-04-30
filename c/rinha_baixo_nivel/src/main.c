#include "cock.h"
#include "messages.h"
#include "random_number.h"
#include "initialize.h"
#include "battle.h"

int main()
{
    // initialize();

    //introduce chicken
    Cock galo1 = createNewCock("Tinhoso", 8, 3, 1);
    Cock galo2 = createNewCock("Garnize", 12, 2, 2);

    combatTurn(&galo1, &galo2);

    cockStatsOneLine(&galo1);
    cockStatsOneLine(&galo2);

    return 0;
}
