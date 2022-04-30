#include <stdio.h>
#include <stdlib.h>

typedef struct No
{
  int valor; // Aqui poderia ser qualquer coisa
  struct No *proximo;
} no;

no *criar_no(int valor)
{
  no *novo_no = malloc(sizeof(no));
  novo_no->valor = valor;
  novo_no->proximo = NULL;
}

int main()
{
  no *primeiro = criar_no(10);
  no *segundo = criar_no(50);
  no *terceiro = criar_no(20);

  primeiro->proximo = segundo;
  segundo->proximo = terceiro;
  terceiro->proximo = NULL;

  return 0;
}