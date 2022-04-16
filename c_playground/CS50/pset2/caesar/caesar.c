#include <cs50.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char encrypt(char letter, int key);

int main(int argc, string argv[])
{
    // Guardclaw for no argument
    if (argc != 2)
    {
        return 1;
    }

    int key = atoi(argv[1]);

    // Guardclaw for no key, or invalid key
    if (key < 1)
    {
        return 1;
    }

    string text = get_string("plaintext: ");
    int n = strlen(text);

    // loop and change
    for (int i = 0; i < n; i++)
    {
        text[i] = encrypt(text[i], key);
    }

    printf("ciphertext: %s\n", text);
}

char encrypt(char letter, int key)
{
    // If is uppercase use the value of 65
    if (isupper(letter) != 0) 
    {
        int index = (int) letter - 65;
        int new_index = (index + key) % 26;
        return new_index + 65;
    }

    // If is lowercase use the value of 97
    if (islower(letter) != 0) 
    {
        int index = (int) letter - 97;
        int new_index = (index + key) % 26;
        return new_index + 97;
    }

    //Otherwise return the original letter
    return letter;
}