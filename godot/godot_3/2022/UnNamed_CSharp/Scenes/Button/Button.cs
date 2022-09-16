using Godot;
using System;

public class Button : Area2D
{
  [Signal] public delegate void ButtonPressed();
  [Signal] public delegate void ButtonReleased();

  public Sprite sprite;
  public AudioStreamPlayer audio;

  public override void _Ready()
  {
    base._Ready();
    audio = GetNode<AudioStreamPlayer>("AudioStreamPlayer");

    sprite = GetNode<Sprite>("Sprite");
    sprite.Frame = 0;

    Connect("body_entered", this, nameof(Button.OnPlayerEntered));
    Connect("body_exited", this, nameof(Button.OnPlayerExited));
  }

  public void OnPlayerEntered(Node body)
  {
    if (body is Player)
    {
      audio.Play();
      EmitSignal(nameof(Button.ButtonPressed));
      sprite.Frame = 1;
    }
  }

  public void OnPlayerExited(Node body)
  {
    if (body is Player)
    {
      audio.Play();
      EmitSignal(nameof(Button.ButtonReleased));
      sprite.Frame = 0;
    }
  }
}
