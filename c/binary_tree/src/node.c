#include <stdlib.h>
#include <stdio.h>
#include "node.h"

void show_tree(Node *node)
{
    if (node->is_null != 0)
    {
        if (node->left != NULL)
        {
            show_tree(node->left);
        }

        printf("Node value is %d\n", node->value);

        if (node->right != NULL)
        {
            show_tree(node->right);
        }
    }
}

void insert_value_on_tree(int value, Node *node)
{
    if (node->is_null == 0)
    {
        node->value = value;
        node->is_null = 1;
        return;
    }

    if (value < node->value)
    {
        if (node->left == NULL)
        {
            Node *new_node = create_node();
            new_node->value = value;
            new_node->is_null = 1;

            node->left = new_node;
            return;
        }

        insert_value_on_tree(value, node->left);
    }

    if (value > node->value)
    {
        if (node->right == NULL)
        {
            Node *new_node = create_node();
            new_node->value = value;
            new_node->is_null = 1;

            node->right = new_node;
            return;
        }

        insert_value_on_tree(value, node->right);
    }
}

Node *create_node()
{
    Node *root = (Node *)malloc(sizeof(Node));

    root->value = 0;
    root->is_null = 0;
    root->left = NULL;
    root->right = NULL;

    return root;
}