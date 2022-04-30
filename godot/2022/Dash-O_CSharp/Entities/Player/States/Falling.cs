using Godot;
using System;
using Godot.Collections;

namespace Entities.Player
{
  public class Falling : PlayerState
  {
    [Export] public string startCoyoteTime = "start_coyote_time";
    [Export] public NodePath coyoteTimerPath;

    public Timer coyoteTimer;

    public override void _Ready()
    {
      base._Ready();
      coyoteTimer = GetNode<Timer>(coyoteTimerPath);
    }

    public override void OnProccess(float delta)
    {
      base.OnProccess(delta);
      CheckGravity(delta);
      movement.ApplyHorizontalForce(player, player.input.direction.x);
      CheckChangeState();
    }

    public override void OnEnter()
    {
      base.OnEnter();
      player.animationPlayer.Play(player.animationList.falling);
    }

    public override void CheckChangeState()
    {
      if (player.input.jump && coyoteTimer.TimeLeft > 0f)
      {
        ChangeState(player.stateList.jump);
        coyoteTimer.Stop();
        return;
      }

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
    }

    public override void Message<T>(T message, string name = "UnNamed")
    {
      base.Message(message, name);

      if (message is String)
      {
        if (message as string == startCoyoteTime) { StartCoyoteTime(); }
      }
    }

    private void StartCoyoteTime()
    {
      movement.ResetMotionY();
      coyoteTimer.Start();
    }

    private void CheckGravity(float delta)
    {
      if (coyoteTimer.TimeLeft <= 0f)
      {
        movement.ApplyGravity(player, delta);
      }
    }
  }
}