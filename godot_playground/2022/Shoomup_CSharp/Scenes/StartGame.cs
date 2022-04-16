using Godot;
using System;

public class StartGame : Control
{
  [Export] public PackedScene initialLevel;

  public Button startButton;
  public Button quitButton;
  public Label scoreLabel;

  public override void _Ready()
  {
    scoreLabel = GetNode<Label>("VBoxContainer/Score");
    int maxScore = PersistentGameData.LoadScore();
    scoreLabel.Text = $"Your score\nis:{maxScore}";

    startButton = GetNode<Button>("VBoxContainer/StartGame");
    startButton.Connect("pressed", this, nameof(StartGame.onStartPress));
    startButton.GrabFocus();

    quitButton = GetNode<Button>("VBoxContainer/QuitGame");
    quitButton.Connect("pressed", this, nameof(StartGame.onQuitPress));
  }

  public void onStartPress()
  {
    GetTree().ChangeSceneTo(initialLevel);
  }

  public void onQuitPress()
  {
    GetTree().Quit();
  }
}
