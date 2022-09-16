using Godot;
using System;

public class BaseEffect : Sprite
{
  public void Die()
  {
    QueueFree();
  }
}
