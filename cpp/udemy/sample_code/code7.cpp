#include <iostream>
#include <cstdlib>
#include <string>
#include <cmath>
#include <ctime>

using namespace std;

/*
Previously I talked about how you can loop with for. We can also continue looping as long as a condition is true with a while loop. While loops are used when you don't know how many times you will have to loop. 

 Here we’ll generate a random number with the random module and randrange(). We will then use the while loop to guess the random value and output it.
*/

int main(){

    // Generate a random number
    srand(time(NULL));
    // Generate a random number up to 10
    int randNum = rand() % 100;

    // The value we increment in the while loop is defined before the loop
    int i = 1;
    while (i != randNum){
        i += 1;
    }
    cout << "The Random Number is " << i << endl;

    /*
    Break & Continue

    Break and continue are very useful. Continue stops executing the code that remains in the loop and jumps back to the top. While break ends execution and jumps directly to the code that lies immediately outside of the loop.

    Here we’ll cycle from 0 to 20 with a while loop. If a number is even will use continue to skip printing it. If it is odd we’ll print it. We’ll then end execution with break if the value ever reaches 15.
    */

   int j = 1;
 
    while (j <= 20){
        // If a value is even don't print it
        if((j % 2) == 0){
            j += 1;
 
            // Continue skips the rest of the code
            // and jumps back to the beginning
            // of the loop
            continue;
        }
 
        // Break stops execution of the loop and jumps
        // to the line after the loops closing }
        if(j == 15) break;
 
        cout << j << endl;
 
        // Increment i so the loop eventually ends
        j += 1;
    }

    // PROBLEM
    /* 
    For this problem I want you to draw a pine tree after asking the user for the number of rows. This problem is the most difficult you have had so far, but it will teach a lot. Feel free to use any resources online to solve it.

    Here is the sample program
 
    How tall is the tree : 5
        #
       ###
      #####
     #######
    #########
        #

    Here are some additional tips to help you solve the problem.

    Tip 1 : You should use a while loop and 3 for loops.

    Tip 2 : I know that this is the number of spaces and hashes for the tree
    4 - 1
    3 - 3
    2 - 5
    1 - 7
    0 - 9
    Spaces before stump = Spaces before top

    TIP 3 : You will need to do the following in your program 
    1. Decrement spaces by one each time through the loop
    2. Increment the hashes by 2 each time through the loop
    3. Save spaces to the stump by calculating tree height - 1
    4. Decrement from tree height until it equals 0
    5. Print spaces and then hashes for each row
    6. Print stump spaces and then 1 hash
    */

   int treeHeight;
   cout << "How Tall is the Tree : ";
   cin >> treeHeight;
   int spaces = treeHeight - 1;
   int hashes = 1;
   int stumpSpaces = treeHeight - 1;

    while (treeHeight != 0){
        for(int k = 0; k < spaces; ++k){
            cout << " ";
        }
        for(int l = 0; l < hashes; ++l){
            cout << "#";
        }
        cout << endl;
        spaces -= 1;
        hashes += 2;
        treeHeight -= 1;
    }
    for(int m = 0; m < stumpSpaces; ++m){
            cout << " ";
    }
    cout << "#\n";

    return 0;
}
