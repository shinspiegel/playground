using Godot;
using System;

public class PopUpMessage : Area2D
{
  [Export] public string text = "";

  private Label message;
  private AnimationPlayer animationPlayer;

  public override void _Ready()
  {
    animationPlayer = GetNode<AnimationPlayer>("AnimationPlayer");
    animationPlayer.Play("hide");

    message = GetNode<Label>("Node2D/Label");
    message.Text = text;
  }

  private void OnBodyEntered(Node body)
  {
    if (body is Player)
    {
      animationPlayer.Play("show");
    }
  }

  private void OnBodyExited(Node body)
  {
    if (body is Player)
    {
      animationPlayer.Play("hide");
    }
  }
}
