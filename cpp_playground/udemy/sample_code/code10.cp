#include <iostream>
#include <cstdlib>
#include <string>
#include <cmath>
#include <ctime>
#include <array>
#include <vector>
#include <sstream>
#include <algorithm> // Needed for find

using namespace std;

int main(){

    // Use vectors when you don't know how big your 
    // arrays may be
    
    // Create a vector with 2 spaces to start
    vector<int> vecRandNums(2);
    
    // Add values 
    vecRandNums[0] = 10;
    vecRandNums[1] = 20;
    
    // Add another value to the vector
    vecRandNums.push_back(30);
    
    // Get size of vector
    cout << "Vector Size : " << vecRandNums.size() << endl;
    
    // Get last value
    cout << "Last Index : " << 
            vecRandNums[vecRandNums.size() - 1] << endl;

    // Check if value in vector
    // Create an iterator that is used to cycle through
    // a range of values
    vector<int>::iterator it;
    // If find finds 20 it provides an iterator
    it = find (vecRandNums.begin(), vecRandNums.end(), 20);
    // We can get the value using the dereference operator 
    // which I'll cover in the next video
    cout << *it << endl;
    
    // Convert a string into an array
    string sSentence = "This is a random string";
    
    // Create a vector
    vector<string> vecsWords;
    
    // A stringstream object receives strings separated
    // by a space and then spits them out 1 by 1
    stringstream ss(sSentence);
    
    // Will temporarily hold each word in the string
    string sIndivStr;
    
    // Defines what separates the words
    char cSpace = ' ';
    
    // While there are more words to extract keep
    // executing
    // getline takes strings from a stream of words stored
    // in the stream and each time it finds a blanks space
    // it stores the word proceeding the space in sIndivStr
    while(getline(ss, sIndivStr, cSpace)){
        
        // Put the string into a vector
        vecsWords.push_back(sIndivStr);
    }
    
    // Cycle through each index in the vector and print
    // out each word 
    for(int i = 0; i < vecsWords.size(); ++i){
        cout << vecsWords[i] << endl;
    }

    // PROBLEM
    // Enter calculation (ex. 5 + 6) : 10 - 6
    // 10.0 - 6.0 = 4.0

    double dbNum1 = 0, dbNum2 = 0;
    string sCalc = "";
    vector<string> vecsCalc; 
    
    cout << "Enter calculation (ex. 5 + 6): ";
    getline(cin, sCalc);
    
    stringstream ss2(sCalc);
    string indivStr;
    char space = ' ';
    
    while(getline(ss2, indivStr, space)){
        vecsCalc.push_back(indivStr);
    }
    
    dbNum1 = stoi(vecsCalc[0]);
    dbNum2 = stoi(vecsCalc[2]);
    string operation = vecsCalc[1];
    
    if (operation == "+"){
        printf("%.1f + %.1f = %.1f\n", dbNum1, dbNum2,
                (dbNum1 + dbNum2));
    } else if (operation == "-"){
        printf("%.1f - %.1f = %.1f\n", dbNum1, dbNum2,
                (dbNum1 - dbNum2));
    } else if (operation == "*"){
        printf("%.1f * %.1f = %.1f\n", dbNum1, dbNum2,
                (dbNum1 * dbNum2));
    } else if (operation == "/"){
        printf("%.1f / %.1f = %.1f\n", dbNum1, dbNum2,
                (dbNum1 / dbNum2));
    } else {
        cout << "Please enter only +, -, *, or /\n";
    }

    return 0;
}
