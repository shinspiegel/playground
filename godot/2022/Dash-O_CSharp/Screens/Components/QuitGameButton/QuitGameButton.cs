using Godot;
using System;

namespace Screens
{
  public class QuitGameButton : Godot.Button
  {
    public override void _Ready()
    {
      Connect("pressed", this, nameof(QuitGameButton.OnPress));
    }

    public void OnPress()
    {
      GetTree().Quit();
    }
  }
}
