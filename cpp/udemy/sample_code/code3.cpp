#include <cstdlib>
#include <iostream>
#include <string>
using namespace std;
 
int main() {
     
    // Create a string
    string sQuestion ("Enter Number 1 : ");
    
    // Create empty strings to store values
    string sNum1, sNum2;
    
    cout << sQuestion;
    
    // Receive user input and store it
    cin >> sNum1;
    
    cout << "Enter Number 2 : ";
    cin >> sNum2;
    
    // Convert from strings to int
    // stod converts from strings to doubles
    int nNum1 = stoi(sNum1);
    int nNum2 = stoi(sNum2);
    
    // Math Operators
    printf("%d + %d = %d\n", nNum1, nNum2, (nNum1 + nNum2));
    printf("%d - %d = %d\n", nNum1, nNum2, (nNum1 - nNum2));
    printf("%d * %d = %d\n", nNum1, nNum2, (nNum1 * nNum2));
    printf("%d / %d = %d\n", nNum1, nNum2, (nNum1 / nNum2));
    printf("%d %% %d = %d\n", nNum1, nNum2, (nNum1 % nNum2));
    
    // ----- PROBLEM : MILES TO KILOMETERS -----
    // Sample knowing that kilometers = miles * 1.60934
    // Enter Miles : 5
    // 5 miles equals 8.0467 kilometers
    
    // Create needed variables
    string sMiles;
    double dMiles, dKilometers;
    
    // Ask user to input miles and store string input
    cout << "Enter Miles : ";
    cin >> sMiles;
    
    // Convert from string to double
    dMiles = stod(sMiles);
    
    // Convert from miles to km
    dKilometers = dMiles * 1.60934;
    
    // Output the results
    printf("%.1f miles equals %.4f kilometers\n", dMiles, dKilometers);
    
    return 0;
}
