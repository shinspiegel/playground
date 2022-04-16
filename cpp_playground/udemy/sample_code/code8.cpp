#include <iostream>
#include <cstdlib>
#include <string>
#include <cmath>
#include <ctime>

using namespace std;

// Do while loops are guaranteed to execute at least once
// We'll create a secret number guessing game

int main(){

    srand(time(NULL));
    // Generate a random number up to 10
    int secretNum = rand() % 11;
    int guess = 0;
    do{
        cout << "Guess the Number : ";
        cin >> guess;
        if(guess > secretNum) cout << "To Big\n";
        if(guess < secretNum) cout << "To Small\n";
    } while(secretNum != guess);
 
    cout << "You guessed it" << endl;

    // PROBLEM
    // Recreate the previous Do While Loop Guessing Game
    // with a While Loop

    secretNum = rand() % 11;
    while(true){
        cout << "Guess the number : ";
        cin >> guess;
        
        if(guess > secretNum) cout << "To Big\n";
        if(guess < secretNum) cout << "To Small\n";
        
        if(guess == secretNum) break;
    }
    
    cout << "You guessed it\n";

    return 0;
}
