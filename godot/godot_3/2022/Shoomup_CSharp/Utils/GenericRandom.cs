using Godot;
using System;

/// <summary>
/// This is a generic random numbers class to be used as a static
/// </summary>
public static class GenericRandom
{
  public static Random random = new Random();

  /// <summary>
  /// This will return a random double between 0.0 and 1.0
  /// </summary>
  static public double Rand()
  {
    return GenericRandom.random.NextDouble();
  }

  /// <summary>
  /// This will return a random int.<br/>
  /// This will also include the max value on the return.<br/>
  /// e.g.: If max is 5, five is one possible return value.<br/>
  /// </summary>
  /// <param name="min">Minimum returned value, defaulted to 0</param>
  /// <param name="max">Maximum returned value, defaulted to 1</param>
  static public int Int(float min = 0, float max = 1)
  {
    return Mathf.FloorToInt((float)GenericRandom.Rand() * ((max + 1) - min) + min);
  }

  /// <summary>
  /// This will return a random float.</br>
  /// This will also incluse the max value on the return.</br>
  /// e.g.: If max is 5.0f, this value is also one possible return value.</br>
  /// </summary>
  /// <param name="min">Minimum returned value, defaulted to 0</param>
  /// <param name="max">Maximum returned value, defaulted to 1</param>
  static public float Float(float min = 0, float max = 1)
  {
    return (float)GenericRandom.Rand() * (max - min) + min;
  }
}
