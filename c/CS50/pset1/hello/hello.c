#include <stdio.h>
#include <cs50.h>

int main(void)
{
    // Get user input name
    string user_input = get_string("What is your name?\n");

    //Print name
    printf("Hellom %s \n", user_input);
}