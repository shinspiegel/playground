#include <stdio.h>
#include <stdlib.h>

typedef struct node
{
    int data;
    struct node *next;
} node;

typedef struct linked_list
{
    node *head;
    int count;
} linked_list;

void insert(int value, linked_list *linked_list)
{
    node *new_node = malloc(sizeof(node));
    new_node->data = value;
    new_node->next = NULL;

    new_node->next = linked_list->head;
    linked_list->count += 1;
    linked_list->head = new_node;
}

void show_list(linked_list *linked_list)
{
    node *current = linked_list->head;

    printf("Start data read. With a total of: %d\n", linked_list->count);

    while (current != NULL)
    {
        printf("Data from the node: %d\n", current->data);
        current = current->next;
    }

    printf("End of data read.\n");
}

node *remove_from_list(int index, linked_list *linked_list)
{
    if (linked_list->head == NULL)
    {
        return NULL;
    }

    if (index > linked_list->count)
    {
        return NULL;
    }

    node *current = linked_list->head;
    node *last_one = NULL;

    int count = 0;

    while (1)
    {
        if (index == 0)
        {
            linked_list->count--;
            linked_list->head = current->next;
            return current;
        }

        if (count == index)
        {
            linked_list->count--;
            last_one->next = current->next;
            return current;
        }

        last_one = current;
        current = current->next;
        count++;
    }
}

linked_list *generate_linked_list()
{
    linked_list *list;
    list = malloc(sizeof(linked_list));
    list->head = NULL;
    list->count = 0;

    return list;
}

int main(int argc, char const *argv[])
{
    linked_list *list = generate_linked_list();

    insert(5, list);
    insert(10, list);
    insert(15, list);
    insert(30, list);

    show_list(list);

    node *removed = remove_from_list(0, list);

    show_list(list);

    printf("Removed data %d\n", removed->data);

    return 0;
}
