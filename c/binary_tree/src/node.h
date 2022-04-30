#ifndef NODE_H
#define NODE_H

typedef struct Node
{
    int value;
    int is_null;
    struct Node *left;
    struct Node *right;

} Node;

void insert_value_on_tree(int value, Node *node);
Node *create_node();
void show_tree(Node *node);

#endif