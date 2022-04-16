using Godot;
using System;

public class HurtBox : Area2D
{
  [Signal] public delegate void DamageReceived(HitBox hit, Damage damage);
  [Signal] public delegate void ColdownFinished();

  public Timer coldown;
  public CollisionShape2D shape;

  public override void _Ready()
  {
    base._Ready();
    coldown = GetNode<Timer>("Coldown");
    shape = GetNode<CollisionShape2D>("CollisionShape2D");

    Connect("area_entered", this, nameof(HurtBox.OnAreaEntered));
    coldown.Connect("timeout", this, nameof(HurtBox.OnColdownTimeout));
  }

  public void OnColdownTimeout()
  {
    shape.Disabled = false;
    EmitSignal(nameof(HurtBox.ColdownFinished));
  }

  public void OnAreaEntered(Area2D area)
  {
    if (area is HitBox && coldown.TimeLeft == 0)
    {
      coldown.Start();
      shape.Disabled = true;
      EmitSignal(
        nameof(HurtBox.DamageReceived),
        (HitBox)area,
        ((HitBox)area).damage
      );
    }
  }
}
