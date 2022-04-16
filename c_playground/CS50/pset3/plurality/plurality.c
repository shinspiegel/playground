#include <cs50.h>
#include <stdio.h>
#include <string.h>

#define MAX 9

typedef struct
{
    string name;
    int votes;
}
candidate;

candidate candidates[MAX];
int candidate_count;

void print_winner(void);
bool vote(string name);

int main(int argc, string argv[])
{
    if (argc < 2)
    {
        printf("Missing arguments, plurality [candidate ...]\n");
        return 1;
    }

    if (candidate_count > MAX)
    {
        printf("Invalid number of candidates, max is %i\n", MAX);
        return 2;
    }

    candidate_count = argc - 1;

    for (int i = 0; i < candidate_count; i++)
    {
        candidates[i].name = argv[i + 1];
        candidates[i].votes = 0;
    }

    int number_voters = get_int("Number of voters: ");

    for (int i = 0; i < number_voters; i++)
    {
        string name = get_string("Vote: ");

        if (!vote(name))
        {
            printf("Invalid vote.\n");
        }
    }

    print_winner();
}

bool vote(string vote_name)
{
    for (int i = 0; i < candidate_count; i++)
    {
        if (strcmp(candidates[i].name, vote_name) == 0)
        {
            candidates[i].votes++;
            return true;
        }
    }
    return false;
}

void print_winner(void)
{
    int maxvotes = 0;
    for (int i = 0; i < candidate_count; i++)
    {
        if (candidates[i].votes > maxvotes)
        {
            maxvotes = candidates[i].votes;
        }
    }

    for (int i = 0; i < candidate_count; i++)
    {
        if (candidates[i].votes == maxvotes)
        {
            printf("%s\n", candidates[i].name);
        }
    }
    return;
}