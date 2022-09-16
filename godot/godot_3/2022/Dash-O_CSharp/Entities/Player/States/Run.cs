using Godot;
using System;

namespace Entities.Player
{
  public class Run : PlayerState
  {
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
      player.animationPlayer.Play(player.animationList.run);
    }

    public override void CheckChangeState()
    {
      if (player.input.direction.x == 0)
      {
        ChangeState(player.stateList.idle);
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
      }
    }
  }
}