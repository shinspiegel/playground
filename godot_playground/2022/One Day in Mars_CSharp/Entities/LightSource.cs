using Godot;
using System;

public class LightSource : Area2D
{
  public Sprite sprite;

  public override void _Ready()
  {
    sprite = GetNode<Sprite>("Sprite");
    sprite.Frame = 0;
  }

  public void OnBodyEntered(Node2D body)
  {
    if (body is Player)
    {
      Player player = (Player)body;
      player.levelManager.UpdateCheckpoint(this);
    }
  }

  public void Activate()
  {
    sprite.Frame = 1;
  }

  public void Deactivate()
  {
    sprite.Frame = 0;
  }
}
