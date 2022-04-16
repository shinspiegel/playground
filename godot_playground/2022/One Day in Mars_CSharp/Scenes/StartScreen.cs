using Godot;
using System;

public class StartScreen : Control
{
  private Button start;
  private Button quit;
  private PackedScene firstLevel;

  public override void _Ready()
  {
    start = GetNode<Button>("VBoxContainer/Start");
    quit = GetNode<Button>("VBoxContainer/Quit");
    firstLevel = ResourceLoader.Load<PackedScene>("res://Levels/Main.tscn");

    start.GrabFocus();
  }

  private void StartGame()
  {
    GetTree().ChangeSceneTo(firstLevel);
  }

  private void QuitGame()
  {
    GetTree().Quit();
  }
}
