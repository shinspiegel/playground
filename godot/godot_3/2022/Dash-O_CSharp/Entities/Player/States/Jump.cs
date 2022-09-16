using Godot;
using System;

namespace Entities.Player
{
  public class Jump : PlayerState
  {
    [Export] float animationPeakAnimation = -50f;

    public override void OnProccess(float delta)
    {
      base.OnProccess(delta);
      movement.ApplyGravity(player, delta);
      movement.ApplyHorizontalForce(player, player.input.direction.x);
      CheckAnimationPeak();
      CheckChangeState();
    }

    public override void OnEnter()
    {
      base.OnEnter();
      movement.ApplyJumpForce();
      player.animationPlayer.Play(player.animationList.jumpUp);
    }

    public override void CheckChangeState()
    {
      if (movement.IsFalling())
      {
        if (player.IsGrounded() && player.input.direction.x == 0)
        {
          ChangeState(player.stateList.run);
          return;
        }

        if (player.IsGrounded() && player.input.direction.x != 0)
        {
          ChangeState(player.stateList.idle);
          return;
        }

        ChangeState(player.stateList.falling);
      }
    }

    private void CheckAnimationPeak()
    {
      if (movement.motion.y >= animationPeakAnimation)
      {
        player.animationPlayer.Play(player.animationList.jumpPeak);
      }
    }
  }
}