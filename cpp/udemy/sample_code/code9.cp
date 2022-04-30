#include <iostream>
#include <cstdlib>
#include <string>
#include <cmath>
#include <ctime>
#include <array>

using namespace std;

int main(){

    // An array is a collection of data of the same type
    // Declare an array of ints with the value of 1
    // Once the size is defined it can't change
    int arrNums[10] = {1};
    
    // Leave out the array length
    int arrNums2[] = {1,2,3};
    
    // Create an array and assign some values
    int arrNums3[5] = {8, 9};
    
    // Access array values using indexes starting with 0
    cout << "1st Value : " << arrNums3[0] << endl;
    
    // Change a value
    arrNums3[0] = 7;
    cout << "1st Value : " << arrNums3[0] << endl;
    
    // Get array size by getting the number of bytes
    // set aside for the array and then divide by the size
    // of the 1st element
    cout << "Array size : " << 
            sizeof(arrNums3) / sizeof(*arrNums3) << endl;

    // Print array items
    for(auto x: arrNums2) cout << x << endl;

    // Print the long way by first calculating the size
    int arrSize = sizeof(arrNums2)/sizeof(arrNums2[0]);
    for(int i = 0; i < arrSize; ++i){
        cout << arrNums2[i] << endl;
    }

    // We can create array objects which come with functions
    array<int,5> arrNums4 = {9, 8, 7, 6};
    // Begin and End point to those parts of the array
    for ( auto j = arrNums4.begin(); j != arrNums4.end(); ++j ){
        cout << " " << *j;
    }
    cout << endl;

    // We can get its size and max size
    cout << "Size : " << arrNums4.size() << endl;
    cout << "Max Size : " << arrNums4.max_size() << endl;

    // We can check if empty
    cout << "Empty : " << (arrNums4.empty() ? "Yes" : "No") << endl;

    // Get values in multiple ways
    cout << "1st : " << arrNums4[0] << endl;
    cout << "2nd : " << arrNums4.at(1) << endl;

    // Overwrite and fill with a value
    arrNums4.fill(5);

    // You can swap values in arrays as long as the type
    // and size is the same
    array<int,5> arrNums5 = {9, 8, 7, 6};
    // Values in 4 go into 5
    arrNums5.swap(arrNums4);
    for(auto x: arrNums5) cout << x << endl;

    // If you need a resizable array it is better to use
    // vectors which I'll cover next time
    
    // A multidimensional array is like a spreadsheet
    // If you think of each as layers that contain columns
    // 1st Number : Which layer
    // 2nd Number : Which column
    // 3rd Number : Which row
    int arrnNums4[2][2][2] = {{{1,2}, {3,4}},
    {{5,6}, {7,8}}};
    cout << arrnNums4[1][1][1] << endl;

    return 0;
}
