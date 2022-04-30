#include <stdio.h>
#include <stdlib.h>

int main(int argc, char const *argv[])
{
    float raio = 0.0;
    float area = 0.0;
    float MenorArea = -1.0;

    float PI = 3.1415;
    int numero = 0;

    printf("Escreva a quantidade de raios na area da sua praia: ");
    scanf("%d", &numero);
    printf("\n");

    while (numero > 0)
    {
        printf("informe o valor do raio: ");
        scanf("%f", &raio);
        printf("\n");

        area = PI * (raio * raio);

        if (MenorArea == -1.0)
        {
            MenorArea = area;
        }

        if (area < MenorArea)
        {
            MenorArea = area;
        }

        numero--;
    }

    printf("A menor area e: %f\n", MenorArea);

    return 0;
}
