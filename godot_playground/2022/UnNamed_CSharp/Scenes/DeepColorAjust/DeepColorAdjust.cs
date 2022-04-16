using Godot;
using System;

public class DeepColorAdjust : CanvasModulate
{
  [Export] float deep = 0.8f;

  public override void _Ready()
  {
    base._Ready();
    Color = new Color(deep, deep, deep, 1);
  }

  public void UpdateModulate(float deep)
  {
    Color = new Color(deep, deep, deep, 1);
  }
}
