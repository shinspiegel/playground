using Godot;
using System;

namespace Utils
{
  public static class GenericRandom
  {
    public static Random random = new Random();

    static public double Rand()
    {
      return GenericRandom.random.NextDouble();
    }

    static public int Int(float min = 0f, float max = 1f)
    {
      return Mathf.FloorToInt((float)GenericRandom.Rand() * ((max + 1) - min) + min);
    }

    static public float Float(float min = 0f, float max = 1f)
    {
      return (float)GenericRandom.Rand() * (max - min) + min;
    }
  }
}