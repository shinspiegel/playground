using Godot;
using System;

public class Hit : PlayerState
{
  public static string HitObjectMessage = "HitObjectMessage";

  public override void _Ready()
  {
    base._Ready();
    SetupHurtBox();
  }

  public override void OnProccess(float delta)
  {
    base.OnProccess(delta);
    player.ApplyGravity(delta);
  }

  public override void OnEnter()
  {
    base.OnEnter();
    player.enableFlipOnMove = false;
    player.motion = Vector2.Zero;
    player.animationPlayer.Play(PlayerContants.animHit);
  }

  public override void OnExit()
  {
    base.OnExit();
    player.enableFlipOnMove = true;
  }

  public override void Message<T>(T message, string name = "UnNamed")
  {
    base.Message(message, name);
    if (message is HitBox && name == Hit.HitObjectMessage)
    {
      HitBox hit = message as HitBox;
      player.ApplyHitMotion(hit);
    }
  }

  public void OnHurtColdownFinished()
  {
    ChangeState(PlayerContants.stateIdle);
  }

  async private void SetupHurtBox()
  {
    await ToSignal(player, "ready");

    player.hurtBox.Connect(
      nameof(HurtBox.ColdownFinished),
      this,
      nameof(Hit.OnHurtColdownFinished)
    );
  }
}
