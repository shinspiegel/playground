#ifndef MATH_UTILS
#define MATH_UTILS

struct Rectangle
{
    double length;
    double width;
};

namespace area
{
    double area(double length, double width);

    double area(double length);

    double area(Rectangle rect);
} // namespace area

#endif