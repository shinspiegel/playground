using Godot;
using System;

namespace Scenes
{
  public class Terminal : Node2D
  {
    [Signal] public delegate void ChangedTo(bool value);

    [Export] public bool enabled = true;

    public AnimationPlayer animationPlayer;

    public override void _Ready()
    {
      base._Ready();
      animationPlayer = GetNode<AnimationPlayer>("AnimationPlayer");
      SetEnabled(enabled);
    }

    public void Activate() { SetEnabled(true); }
    public void Desactivate() { SetEnabled(false); }

    public void SetEnabled(bool value)
    {
      animationPlayer.Play(value ? "On" : "Off");
      enabled = value;
      EmitSignal(nameof(Terminal.ChangedTo), value);
    }
  }
}