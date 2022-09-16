using Godot;
using System;

namespace Entities.Player
{
  public class Idle : PlayerState
  {
    [Export] public float deadZone = 0f;

    public override void OnProccess(float delta)
    {
      base.OnProccess(delta);
      movement.ApplyGravity(player, delta);
      movement.ApplyHorizontalForce(player, player.input.direction.x);
      CheckChangeState();
    }

    public override void OnEnter()
    {
      base.OnEnter();
      player.animationPlayer.Play(player.animationList.idle);
    }

    public override void CheckChangeState()
    {
      if (Mathf.Abs(player.input.direction.x) != deadZone)
      {
        ChangeState(player.stateList.run);
        return;
      }

      if (player.input.jump)
      {
        ChangeState(player.stateList.jump);
        return;
      }

      if (!player.IsGrounded())
      {
        ChangeState(player.stateList.falling);
        player.stateManager.SendMessage("start_coyote_time");
        return;
      }

      if (player.input.roll)
      {
        ChangeState(player.stateList.roll);
        return;
      }
    }
  }
}