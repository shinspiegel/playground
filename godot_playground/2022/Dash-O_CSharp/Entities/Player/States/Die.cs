using Godot;
using System;
using Godot.Collections;

namespace Entities.Player
{
  public class Die : PlayerState
  {
    [Export] public NodePath animationPlayerPath;

    private AnimationPlayer animationPlayer;

    public override void _Ready()
    {
      base._Ready();
      animationPlayer = GetNode<AnimationPlayer>(animationPlayerPath);
      animationPlayer.Connect(
        "animation_finished",
        this,
        nameof(Die.OnAnimationFinished)
      );
    }

    public override void OnEnter()
    {
      player.animationPlayer.Play(player.animationList.death);
      player.movement.ResetMotion();
    }

    private void OnAnimationFinished(string anim)
    {
      if (anim == player.animationList.death)
      {
        player.EmitSignal(nameof(Player.PlayerDied));
      }
    }
  }
}