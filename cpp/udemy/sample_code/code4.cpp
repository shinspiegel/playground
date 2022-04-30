#include <cstdlib>
#include <iostream>
#include <string>
using namespace std;
 
int main() {

    // ----- CONDITIONAL OPERATORS -----
    // Conditional operators help you to perform
    // different actions depending on conditions
    // ==, !=, <, >, <=, >=
    
    // ----- LOGICAL OPERATORS -----
    // Logical operators allow you to combine conditions
    // && : If both are true it returns true
    // || : If either are true it returns true
    // ! : Converts true into false and vice versa
 
    // ----- EXAMPLE : IS A BIRTHDAY IMPORTANT -----
    // 1 - 18, 21, 50, > 65 : Important
    // All others are not important
    
    string sAge = "0";
    cout << "Enter your age : ";
    cin >> sAge;
    int nAge = stoi(sAge);
    
    // if and else is used to execute different code
    // depending on conditions
    if ((nAge >= 1) && (nAge <= 18)){
        cout << "Important Birthday\n";
    } else if ((nAge == 21) || (nAge == 50)) {
        cout << "Important Birthday\n";
    } else if (nAge >= 65){
        cout << "Important Birthday\n";
    } else {
        cout << "Not an Important Birthday\n";
    }
 
    // ----- PROBLEM : DETERMINE SCHOOL GRADE -----
    // If age 5 "Go to Kindergarten"
    // Ages 6 through 17 go to grades 1 through 12
    // If age > 17 "Go to college"
    // Enter age : 2
    // Too young for school
    // Enter age : 8
    // Go to grade 3
    // Try to do with 15 or less lines of code
    
    string sAge2 = "0";
    int nGrade2 = 0;
    cout << "Enter age : ";
    cin >> sAge2;
    int nAge2 = stoi(sAge);
    
    if (nAge2 < 5)
        cout << "To young for school\n";
    else if (nAge2 == 5)
        cout << "Go to Kindergarten\n";
    else if ((nAge2 > 5) && (nAge2 <= 17)){
        nGrade2 = nAge2 - 5;
        cout << "Go to grade " << nGrade2 << "\n";
    } else
        cout << "Go to college\n";

    // A ternary operator works like a compact if else
    // statement. If the condition is true the first
    // value is stored and otherwise the second
    int age43 = 43;
    bool canIVote = (age43 >= 18) ? true : false;
    // Shows bool values as true or false
    cout.setf(ios::boolalpha);
    cout << "Can Derek Vote : " << canIVote << endl;

    return 0;
}
