using Godot;
using System;

public class WallSlide : PlayerState
{
  [Export] public float gravityModifier = 0.4f;

  public override void OnProccess(float delta)
  {
    base.OnProccess(delta);

    player.ApplyGravity(delta, gravityModifier);
    player.ApplyWallJump();
    player.ApplyHorizontalForce();
    player.ConsumeStamina(delta);

    CheckChangeState();
  }

  public override void CheckChangeState()
  {
    if (player.stamina <= 0)
    {
      ChangeState(PlayerContants.stateIdle);
      return;
    }

    if (
      player.IsGrounded() ||
      !player.wallJumpCheck.IsColliding()
      )
    {
      ChangeState(PlayerContants.stateRun);
      return;
    }

    if (player.input.direction.x != player.facingDirection)
    {
      ChangeState(PlayerContants.stateIdle);
      return;
    }
  }

  public override void OnEnter()
  {
    base.OnEnter();
    player.motion = Vector2.Zero;
    player.animationPlayer.Play(PlayerContants.animWallSlide);
    player.wallParticles.Emitting = true;
  }

  public override void OnExit()
  {
    base.OnExit();
    player.wallParticles.Emitting = false;
  }
}
