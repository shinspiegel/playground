#include <stdio.h>
#include <stdlib.h>
#include <locale.h>
#include <string.h>

#define MAX_NAME 50

typedef struct candidate
{
    int vote_code;
    int votes;
    char name[MAX_NAME];

} candidate;

candidate create_candidate(int vote_code, char name[]);
void generate_alderman_list(candidate list[]);
void generate_mayor_list(candidate list[]);
int get_user_input(char message[]);
void show_main_menu();
void run_voting(candidate alderman_list[], candidate mayor_list[]);
void count_votes(candidate alderman_list[], candidate mayor_list[]);

int main(int argc, char const *argv[])
{

    int option = 0;
    candidate alderman_list[3];
    candidate mayor_list[2];

    generate_alderman_list(alderman_list);
    generate_mayor_list(mayor_list);

    while (option != 3)
    {
        system("clear");
        show_main_menu();
        option = get_user_input("Opções: ");
        system("clear");

        switch (option)
        {
        case 1:
            run_voting(alderman_list, mayor_list);
            break;

        case 2:
            count_votes(alderman_list, mayor_list);
            break;

        default:
            break;
        }
    }

    return 0;
}

candidate create_candidate(int vote_code, char name[])
{
    candidate candidate;
    strcpy(candidate.name, name);
    candidate.vote_code = vote_code;
    candidate.votes = 0;

    return candidate;
}

void generate_alderman_list(candidate list[])
{
    list[0] = create_candidate(111, "Vereador Joao do Frete");
    list[1] = create_candidate(222, "Vereador Maria da Pamonha");
    list[2] = create_candidate(333, "Vereador Ze da Farmacia");
}

void generate_mayor_list(candidate list[])
{
    list[0] = create_candidate(11, "Prefeito Dr. Zureta");
    list[1] = create_candidate(22, "Prefeito Senhor Gomes");
}

void show_main_menu()
{
    int option = 0;

    printf("******************************\n");
    printf("**    Eleições Municipais   **\n");
    printf("1 - Votar\n");
    printf("2 - Apuração de votos\n");
    printf("3 - Sair\n");
    printf("******************************\n");
}

int get_user_input(char message[])
{
    int option = 0;
    printf("%s", message);
    scanf("%d", &option);
    fflush(stdin);
    return option;
}

void run_voting(candidate alderman_list[], candidate mayor_list[])
{
    int vote = 0;

    vote = get_user_input("Qual o numero do seu candidato para vereador?: ");

    for (int i = 0; i < 3; i++)
    {
        if (alderman_list[i].vote_code == vote)
        {
            alderman_list[i].votes += 1;
        }
    }

    vote = get_user_input("Qual o numero do seu candidato para prefeito?: ");

    for (int i = 0; i < 2; i++)
    {
        if (mayor_list[i].vote_code == vote)
        {
            mayor_list[i].votes += 1;
        }
    }
}

void count_votes(candidate alderman_list[], candidate mayor_list[])
{

    printf("Estes é a apuração atual dos votos:\n\n");

    printf("Vereador:\n");
    for (int i = 0; i < 3; i++)
    {
        printf(
            "%d - %s tem %d votos.\n",
            alderman_list[i].vote_code,
            alderman_list[i].name,
            alderman_list[i].votes);
    }

    printf("\nPrefeito:\n");
    for (int i = 0; i < 2; i++)
    {
        printf(
            "%d - %s tem %d votos.\n",
            mayor_list[i].vote_code,
            mayor_list[i].name,
            mayor_list[i].votes);
    }

    get_user_input("");
}
