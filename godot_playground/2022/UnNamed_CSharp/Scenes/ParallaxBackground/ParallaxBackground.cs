using Godot;
using System;

public class ParallaxBackground : Godot.ParallaxBackground
{
  [Export] float deep = 0.8f;

  public CanvasModulate canvasModulate;

  public override void _Ready()
  {
    base._Ready();
    canvasModulate = GetNode<CanvasModulate>("CanvasModulate");
    canvasModulate.Color = new Color(deep, deep, deep, 1);
  }

  public void UpdateModulate(float deep)
  {
    canvasModulate.Color = new Color(deep, deep, deep, 1);
  }
}
