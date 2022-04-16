using Godot;
using System;

public class BaseEffect : Sprite
{
  public AnimationPlayer animationPlayer;

  public override void _Ready()
  {
    base._Ready();
    animationPlayer = GetNode<AnimationPlayer>("AnimationPlayer");
    animationPlayer.Connect(
      "on_animation_finished",
      this,
      nameof(BaseEffect.OnAnimationFinish)
    );
  }

  public void OnAnimationFinish()
  {
    QueueFree();
  }
}
