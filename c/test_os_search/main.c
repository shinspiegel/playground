#include <stdio.h>

#ifndef _OSDETECT_H
#define _OSDETECT_H

typedef enum __OS
{
  Unixbased,
  MacOSX,
  Win64
} __OS;

#if defined __unix__
#define PLATFORM_NAME Unixbased
#elif defined __APPLE__
#define PLATFORM_NAME MacOSX
#elif defined _WIN64
#define PLATFORM_NAME Win64
#endif

#endif

int main(int argc, char const *argv[])
{
  printf("%d", PLATFORM_NAME);
  return 0;
}
