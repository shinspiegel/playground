#include <cs50.h>
#include <stdio.h>
#include <math.h>
#include <string.h>
#include <ctype.h>

int is_alphabetical(char letter);
int is_end(char letter);
int is_blank(char letter);
int get_coleman_index(int letters, int words, int sentences);

int main(void)
{
    //Get user text
    string text = get_string("Text: ");

    //Set local variables for later use
    int lenght = strlen(text);
    int letters = 0;
    int words = 0;
    int sentences = 0;
    int can_count_words = 0;

    for (int i = 0; i < lenght; i++)
    {
        // Should count a word is it ends, or with a blank, but only if have counted a letter first
        if ((is_blank(text[i]) == 1 || is_period(text[i]) == 1) && can_count_words == 1)
        {
            words++;
            can_count_words = 0;
        }
        
        // Count a letter and change the value to count words
        if (is_alphabetical(text[i]) == 1)
        {
            letters++;
            can_count_words = 1;
        }

        if (is_end(text[i]) == 1)
        {
            sentences++;
        }
    }

    //get the index
    int coleman_index = get_coleman_index(letters, words, sentences);

    // print the result
    if (coleman_index < 1) 
    {
        printf("Before Grade 1\n");
        return 0;
    }

    if (coleman_index > 16) 
    {
        printf("Before Grade 16+\n");
        return 0;
    }

    printf("Grade %i\n", coleman_index);
}

int get_coleman_index(int letters, int words, int sentences)
{
    float L = ((float) letters / (float) words) * 100;
    float S = ((float) sentences / (float) words) * 100;
    float index = (0.0588 * L) - (0.296 * S) - 15.8;

    return round(index);
}

// Return a 1 if this is alphabetical, or zero for non-alphabetical
int is_alphabetical(char letter)
{
    if (isalpha(letter) != 0)
    {
        return 1;
    }

    return 0;
}

// Return 1 for a white/tab space, otherwise return 0
int is_blank(char letter)
{
    if (isblank(letter) == 1)
    {
        return 1;
    }

    return 0;
}

// Return 1 if the end of a sentense, otherwise return a 0
int is_end(char letter)
{
    if (letter == '.' || letter == '!' || letter == '?')
    {
        return 1;
    }

    return 0;
}