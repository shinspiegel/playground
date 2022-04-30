#include <string>
#include <iostream>
#include <cstdlib>
#include <ctime>
#include <vector>
#include <fstream>

using std::cin;
using std::cout;
using std::endl;
using std::ifstream;
using std::ofstream;
using std::vector;

void play_game();
int menu_choice();
void print_vector(vector<int> &vector_list);
void best_score(int);

int main()
{
    int choice = 0;

    do
    {
        choice = menu_choice();

        switch (choice)
        {
        case 0:
            cout << "See you soon.";
            return 0;
        case 1:
            play_game();
            break;
        }
    } while (choice != 0);

    return 0;
}

int menu_choice()
{
    int choice = 0;
    cout << "[0] Quit\n";
    cout << "[1] Play Guessing game\n";
    cin >> choice;

    return choice;
}

void play_game()
{
    srand(time(NULL));

    vector<int> guess_list;

    int random = rand() % 101;

    cout << random << endl;
    cout << "Pick a number: ";

    while (true)
    {
        int guess = 0;
        cin >> guess;
        guess_list.push_back(guess);

        if (guess == random)
        {
            cout << "You win!\n";
            break;
        }

        if (guess < random)
            cout << "This was lower...\n";
        if (guess > random)
            cout << "This was greater...\n";
    }

    best_score(guess_list.size());
    print_vector(guess_list);
}

void best_score(int score)
{
    int best_score;

    ifstream input("best_score");

    if (!input.is_open())
    {
        ofstream output("best_score");
        output << score;
        cout << "You beat the best score with: " << score << endl;
        return;
    }

    input >> best_score;

    ofstream output("best_score");
    if (score < best_score)
    {
        output << score;
        cout << "You beat the best score with: " << score << endl;
    }
    else
    {
        output << best_score;
        cout << "The best score is: " << best_score << endl;
    }
}

void print_vector(vector<int> &vector_list)
{
    for (int i = 0; i < vector_list.size(); i++)
    {
        cout << vector_list[i] << "\t";
    }
    cout << endl;
}