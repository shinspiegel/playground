using Godot;
using System;

namespace Resources
{
  public class FloatStat : Resource
  {
    [Signal] public delegate void ChangedValueTo(float current);
    [Signal] public delegate void Changed(float current, float min, float max);
    [Signal] public delegate void ChangedToMin(float min);
    [Signal] public delegate void ChangedToMax(float min);

    [Export] public float min = 0f;
    [Export] public float max = 100f;
    [Export] public float current = 0f;

    public void Reset()
    {
      current = max;
    }

    public void ChangeBy(float value) { UpdateTo(current + value); }

    public void UpdateTo(float value)
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