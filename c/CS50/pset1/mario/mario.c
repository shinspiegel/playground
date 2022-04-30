#include <stdio.h>
#include <cs50.h>

int get_user_height(int max);
void draw_angled_wall(int height);
void draw_line(int lenght, int white_space, int space);
void draw_hash(int max);
void draw_white_space(int max);

int main(void)
{
    int height = get_user_height(8);
    draw_angled_wall(height);
}


//This function will draw based on a height
void draw_angled_wall(int height)
{
    for (int i = height; i > 0; i--)
    {
        draw_line(height - (i - 1), i - 1, 2);
    }
}

// This function will draw a line based on a lenght, white space and spacer
// It will end with a new line
void draw_line(int lenght, int white_space, int space)
{
    // Drawing function that will create the line
    draw_white_space(white_space);
    draw_hash(lenght);
    draw_white_space(space);
    draw_hash(lenght);

    printf("\n");
}

void draw_hash(int max)
{
    // Hash loop
    for (int i = 0; i < max; i++)
    {
        printf("#");
    }
}

void draw_white_space(int max)
{
    // Space loop
    for (int i = 0; i < max; i++)
    {
        printf(" ");
    }
}

//This function will get the heigh from user
int get_user_height(int max)
{
    int height = get_int("Height? \n");

    if (height < 1)
    {
        return get_user_height(max);
    }

    if (height > max)
    {
        return get_user_height(max);
    }

    return height;
}
