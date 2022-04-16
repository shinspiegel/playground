#include <stdio.h>
#include <stdlib.h>
#include "node.h"

int main(int argc, char const *argv[])
{
    Node *root_node = create_node();

    insert_value_on_tree(10, root_node);
    insert_value_on_tree(20, root_node);
    insert_value_on_tree(30, root_node);
    insert_value_on_tree(5, root_node);
    insert_value_on_tree(1, root_node);
    insert_value_on_tree(2, root_node);

    show_tree(root_node);

    return 0;
}
