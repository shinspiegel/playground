using Godot;
using System;

public class ChangeLevelButton : Godot.Button
{
  [Export] public PackedScene level;


  public override void _Ready()
  {
    Connect("pressed", this, nameof(ChangeLevelButton.OnPress));
  }

  public void OnPress()
  {
    GetTree().ChangeSceneTo(level);
  }
}
