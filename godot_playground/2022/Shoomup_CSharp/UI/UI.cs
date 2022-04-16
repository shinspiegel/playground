using Godot;
using System;

public class UI : CanvasLayer
{
  public Label scoreLabel;
  public Label difficultyLabel;
  public ProgressBar shootAmount;

  public override void _Ready()
  {
    scoreLabel = GetNode<Label>("Control/VBoxContainer/HBoxContainer/Score");
    difficultyLabel = GetNode<Label>("Control/VBoxContainer/HBoxContainer/Dificulty");
    shootAmount = GetNode<ProgressBar>("Control/VBoxContainer/HBoxContainer2/ProgressBar");

    OnScoreChange(0);
    OnDifficultyChange(0);
    OnChargeChange(1, 1);
  }

  public void OnChargeChange(int value, int maxValue)
  {
    int amount = (int)(((float)value / (float)maxValue) * 100);
    shootAmount.Value = amount;
  }

  public void OnScoreChange(int score)
  {
    scoreLabel.Text = $"{score}";
  }

  public void OnDifficultyChange(int difficulty)
  {
    difficultyLabel.Text = $"({difficulty})";
  }
}
