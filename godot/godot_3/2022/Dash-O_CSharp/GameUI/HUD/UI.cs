using Godot;
using System;

namespace GameUI
{
  public class UI : CanvasLayer
  {
    public AnimationPlayer animationPlayer;
    public Label secondsLabel;
    public Label minutesLabel;

    public override void _Ready()
    {
      base._Ready();
      animationPlayer = GetNode<AnimationPlayer>("AnimationPlayer");
      minutesLabel = GetNode<Label>("MarginContainer/Control/Control/Control/Minutes");
      secondsLabel = GetNode<Label>("MarginContainer/Control/Control/Control/Seconds");

      OnHitPointChanged(1, 1);
    }

    public void ChangeTimeDisplay(int min, int sec)
    {
      minutesLabel.Text = min.ToString();
      secondsLabel.Text = sec.ToString();
    }

    public void OnHitPointChanged(float current, float max)
    {
      float ratio = current / max;

      if (ratio < 0.2f)
      {
        animationPlayer.Play("Deadly");
      }
      else if (ratio < 0.5f)
      {
        animationPlayer.Play("Warm");
      }
      else
      {
        animationPlayer.Play("Regular");
      }
    }
  }
}