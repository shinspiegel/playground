using Godot;
using System;

public class Idle : PlayerState
{
  [Export] public float deadZone = 20f;

  public override void OnProccess(float delta)
  {
    base.OnProccess(delta);

    player.ApplyGravity(delta);
    player.ApplyHorizontalForce();
    player.ApplyJump();
    player.RecoverStamina(delta);

    CheckChangeState();
  }

  public override void CheckChangeState()
  {
    if (
      player.stamina > 0 && 
      (Mathf.Abs(player.motion.x) > deadZone || player.input.jump)
    )
    {
      ChangeState(PlayerContants.stateRun);
      return;
    }
  }

  public override void OnEnter()
  {
    base.OnEnter();
    player.motion = Vector2.Zero;
    player.animationPlayer.Play(PlayerContants.animIdle);
  }
}
