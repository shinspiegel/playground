// All C++ files end with cpp

// These are called preprocessor directives
// They load the files which contain premade 
// functions for your use
 
// Contains functions for converting from 1 data 
// type to another, random number generation, 
// memory management, searching, math, sorting and 
// other general purpose functions
#include <cstdlib>
 
// Provides functions for performing input and 
// output operations
#include <iostream>
 
// If used you can type cout instead of cout
// By using this though you may have conflicts if 
// you define functions that share a name with the 
// std namespace
using namespace std;

// Execution of code starts in the main function
// argc and argv is optional data that could be 
// passed to the program if it was executed in a 
// terminal
// argc : Number of arguments passed
// argv : Array pointers to strings
int main(int argc, char* argv[]) {
    // Outputs the string Hello World to the 
    // screen followed by a newline
    // cout is your console or screen
    // << : Stream insertion operator which puts 
    // the string into the cout stream to display 
    // it
    cout << "Hello World" << endl;

    // If no arguments are passed argc has a value
    // of 1
    // We check that with if to skip printing 
    // values if none were passed
    if(argc != 1){
    
        // You can also create a newline with \n
        cout << "You entered " << argc << " arguments\n";
    
        // Cycles through all the values in the 
        // argc array and prints them
        // We access the values by using their 
        // index number starting at 0 
        for(int i = 0; i < argc; ++i){
        
            // We access each string passed by 
            // putting its index between []
            // called the subscript operator
            cout << argv[i] << endl;
        }
    }

    // When 0 is returned that signals that the 
    // program executed without an error and -1 
    // signals an error occurred 
    return 0;

    // You can compile in the terminal with
    // g++ -std=c++17 tut1.cpp -o tut1
    // Execute it with ./tut1 Hello C++

    // On Windows open the command line, go to your
    // directory and type tut1 Hello C++
}
