using Godot;
using System;

namespace Levels
{
  public class Level : Node2D
  {
    public void OnPlayerDied()
    {
      GetTree().ReloadCurrentScene();
    }

    public void OnLevelTimeout()
    {
      GD.Print("Level timeout");
    }
  }
}