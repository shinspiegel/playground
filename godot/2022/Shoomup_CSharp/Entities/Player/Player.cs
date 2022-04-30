using Godot;
using System;

public class Player : Actor
{
  [Signal] public delegate void UpdatedAmmo(int value, int maxValue);

  [Export] public int playerShootSpeed = 100;
  [Export] public float maxShootAmmo = 100;
  [Export] public float ammoPerShot = 10;
  [Export] public float rechargeAmmoRate = 3;

  public float currentAmmo = 0;

  public override void _Ready()
  {
    base._Ready();
    currentAmmo = maxShootAmmo;
  }

  public override void _PhysicsProcess(float delta)
  {
    ApplyActor();
  }

  public override void _Process(float delta)
  {
    base._Process(delta);
    RechargeAmmo(delta);
  }

  public override void GetUserInput()
  {
    input.Reset();

    if (Input.IsActionPressed("ui_left")) { input.direction.x = -1; }
    if (Input.IsActionPressed("ui_right")) { input.direction.x = +1; }
    if (Input.IsActionPressed("ui_up")) { input.shoot = true; }
  }

  public override void ApplyShoot()
  {
    if (
      shootColdownTimer.TimeLeft == 0.0f &&
      input.shoot &&
      currentAmmo - ammoPerShot > 0
    )
    {
      base.ApplyShoot();

      currentAmmo -= ammoPerShot;
      EmitSignal(nameof(Player.UpdatedAmmo), currentAmmo, maxShootAmmo);
    }
  }

  public void RechargeAmmo(float delta)
  {
    currentAmmo += rechargeAmmoRate * delta;
    EmitSignal(nameof(Player.UpdatedAmmo), currentAmmo, maxShootAmmo);
  }
}
