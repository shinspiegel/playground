using Godot;
using System;

namespace Resources
{
  public class IntStat : Resource
  {
    [Signal] public delegate void ChangedValueTo(int current);
    [Signal] public delegate void Changed(int current, int min, int max);
    [Signal] public delegate void ChangedToMin(int min);
    [Signal] public delegate void ChangedToMax(int min);

    [Export] public int min = 0;
    [Export] public int max = 100;
    [Export] public int current = 0;

    public void Reset()
    {
      current = max;
    }

    public void ChangeBy(int value) { UpdateTo(current + value); }

    public void UpdateTo(int value)
    {
      if (value < min)
      {
        current = min;
        EmitSignal(nameof(FloatStat.ChangedToMin), min);
      }
      else if (value > max)
      {
        current = max;
        EmitSignal(nameof(FloatStat.ChangedToMax), max);
      }
      else
      {
        current = value;
      }

      EmitSignal(nameof(FloatStat.ChangedValueTo), current);
      EmitSignal(nameof(FloatStat.Changed), current, min, max);
    }
  }
}