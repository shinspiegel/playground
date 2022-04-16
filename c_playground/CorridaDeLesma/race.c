#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_RACES 3
#define MAX_SLUGS 10

struct Slug
{
    int slugID;
    int maxSpeed;
} Slug;

struct Race
{
    int amountOfSlugs;
    struct Slug slugList[MAX_SLUGS];
    struct Slug fastestSlug;
} Race;

struct Race generateRaceData();

int main(int argc, char const *argv[])
{
    // Base structure to run tha races
    struct Race racesGroup[MAX_RACES];

    // File data
    FILE *ptr_file;
    char line[1000];
    ptr_file = fopen("entries.txt", "r");

    // Exit if there is no file
    if (!ptr_file)
    {
        return 1;
    }

    // Main loop to read all the information from the file
    int status = 0;
    int count = 0;

    while (fgets(line, 1000, ptr_file) != NULL)
    {
        // Get the number of slugs
        if (status == 0)
        {
            printf("Enter status 0\n");

            // Flip the status
            status = 1;

            int amount = atoi(line);
            racesGroup[count].amountOfSlugs = amount;
        }

        // Fill the slugs
        if (status == 1)
        {
            printf("Enter status 1\n");

            // Flip the status
            status = 0;
            int j = 0;
            char value[3];

            printf("Iteration %i \n", strlen(line));
            
            // Loop throught all the line
            for (int i = 0; i < strlen(line); i++)
            {
                // Break the loop if on a empty
                if (line[i] == ' ')
                {
                    printf("%s", value);
                    break;
                }

                value[j++] = value[i];
            }
        }

        //Increase the count
        count++;
    }

    fclose(ptr_file);
    return 0;
}