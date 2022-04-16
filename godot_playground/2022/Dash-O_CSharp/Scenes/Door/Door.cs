using Godot;
using System;

namespace Scenes
{
  public class Door : StaticBody2D
  {
    [Signal] public delegate void Opened();
    [Signal] public delegate void Closed();

    public AnimationPlayer animationPlayer;

    public override void _Ready()
    {
      base._Ready();
      animationPlayer = GetNode<AnimationPlayer>("AnimationPlayer");
      animationPlayer.Connect("animation_finished", this, nameof(Door.OnAnimationFinished));
      animationPlayer.Play("Idle");
    }

    public void OnAnimationFinished(string anim)
    {
      if (anim == "Open")
      {
        EmitSignal(nameof(Door.Opened));
      }

      if (anim == "Closed")
      {
        EmitSignal(nameof(Door.Closed));
        animationPlayer.Play("Idle");
      }
    }

    public void Open()
    {
      animationPlayer.Play("Open");
    }

    public void Close()
    {
      animationPlayer.Play("Close");
    }
  }
}
