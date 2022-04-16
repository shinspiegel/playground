using Godot;
using System;

public class HUD : CanvasLayer
{
  [Signal]
  public delegate void StartGame();

  private Label message;
  private Label scoreLabel;
  private Timer messageTimer;
  private Button startButton;


  public override void _Ready()
  {
    message = GetNode<Label>("Message");
    messageTimer = GetNode<Timer>("MessageTimer");
    scoreLabel = GetNode<Label>("ScoreLabel");
    startButton = GetNode<Button>("StartButton");
  }

  public void ShowMessage(string text)
  {
    message.Text = text;
    message.Show();
    messageTimer.Start();
  }

  async public void ShowGameOver()
  {
    ShowMessage("Game Over");
    await ToSignal(messageTimer, "timeout");

    message.Text = "Dodge the\nCreeps!";
    message.Show();

    await ToSignal(GetTree().CreateTimer(1), "timeout");
    startButton.Show();
  }

  public void UpdateScore(int score)
  {
    scoreLabel.Text = score.ToString();
  }

  public void OnStartButtonPressed()
  {
    startButton.Hide();
    EmitSignal("StartGame");
  }

  public void OnMessageTimerTimeout()
  {
    message.Hide();
  }
}
