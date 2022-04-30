using Godot;
using System;

public class Move : PlayerState
{
  [Export] public float deadZone = 20f;

  public override void OnProccess(float delta)
  {
    base.OnProccess(delta);

    player.ApplyGravity(delta);
    player.ApplyHorizontalForce();
    player.ApplyCoyoteTimer();
    player.ApplyJump();
    player.RecoverStamina(delta);

    ApplyAnimation();
    CheckChangeState();
  }

  public override void CheckChangeState()
  {
    if (Mathf.Abs(player.motion.x) < deadZone && Mathf.Abs(player.motion.y) == 0)
    {
      ChangeState(PlayerContants.stateIdle);
      return;
    }

    if (
      !player.IsGrounded() &&
      player.motion.y > 0 &&
      player.wallJumpCheck.IsColliding() &&
      Mathf.Abs(player.motion.x) < deadZone
    )
    {
      ChangeState(PlayerContants.stateWallSlide);
      return;
    }
  }

  public override void OnEnter()
  {
    base.OnEnter();
    player.animationPlayer.Play(PlayerContants.animRun);
  }

  public void ApplyAnimation()
  {
    if (player.motion.x != 0 && player.IsGrounded())
    {
      player.animationPlayer.Play(PlayerContants.animRun);
      return;
    }

    if (!player.IsGrounded())
    {
      player.animationPlayer.Play(PlayerContants.animIdle);
      return;
    }
  }
}
