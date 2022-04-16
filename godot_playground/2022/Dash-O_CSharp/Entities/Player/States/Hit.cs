using Godot;
using System;

namespace Entities.Player
{
  public class Hit : PlayerState
  {
    [Export] public float hitTimer = 0.4f;

    private Timer timer;

    public override void OnProccess(float delta)
    {
      base.OnProccess(delta);
      movement.ApplyGravity(player, delta);
    }

    public override void OnEnter()
    {
      base.OnEnter();
      movement.ResetMotion();
      player.SetEnableFlip(false);
      player.animationPlayer.Play(player.animationList.hit);
      CreateTimer();
    }

    public override void OnExit()
    {
      base.OnExit();
      player.SetEnableFlip(true);
      RemoveChild(timer);
    }

    public override void Message<T>(T message, string name = "UnNamed")
    {
      base.Message(message, name);
      if (message is HitBox)
      {
        HitBox hit = message as HitBox;

        float diff = player.GlobalPosition.x - hit.GlobalPosition.x;
        int direction = diff > 0 ? 1 : -1;

        movement.SetMotion(
          new Vector2(
            x: (float)direction * hit.damage.horizontalForce,
            y: -hit.damage.verticalForce
          )
        );
      }
    }

    public void OnTimeout()
    {
      ChangeState(player.stateList.idle);
    }

    private void CreateTimer()
    {
      timer = new Timer();
      AddChild(timer);
      timer.Connect("timeout", this, nameof(Hit.OnTimeout));
      timer.Start(hitTimer);
    }
  }
}
