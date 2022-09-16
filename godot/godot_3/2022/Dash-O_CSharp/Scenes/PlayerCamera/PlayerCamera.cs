using Godot;
using System;

namespace Scenes
{
  public class PlayerCamera : Camera2D
  {
    public override void _Ready()
    {
      base._Ready();
      Current = true;
    }
  }
}