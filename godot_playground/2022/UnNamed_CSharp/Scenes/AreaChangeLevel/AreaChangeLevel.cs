using Godot;
using System;

public class AreaChangeLevel : Area2D
{
  public override void _Ready()
  {
    Connect("body_entered", this, nameof(AreaChangeLevel.OnEnter));
  }

  public void OnEnter(Node body)
  {
    if (body is Player)
    {
      GetTree().ChangeScene("res://Scenes/Screens/GameOver/GameOver.tscn");
    }
  }
}
