using Godot;
using System;

public class GameOver : Control
{
  private Timer timer;

  public override void _Ready()
  {
    timer = GetNode<Timer>("Timer");
    QuitGame();
  }

  async public void QuitGame()
  {
    await ToSignal(timer, "timeout");
    GetTree().Quit();
  }
}
