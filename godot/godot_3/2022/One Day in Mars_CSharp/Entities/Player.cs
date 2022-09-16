using Godot;
using System;

public class Player : Actor
{
  [Signal] public delegate void OnUpdateBattery(float current, float total);
  [Signal] public delegate void OnDie();

  public LevelManager levelManager;

  private float battery;
  private float maxBattery = 50;
  private float rechargeBatteryRate = EnergyConsuptionRate.recharge;
  private float consuptionBatteryRate = EnergyConsuptionRate.zero;
  private bool isRecharging = false;
  private Area2D lightDetector;
  private AnimationPlayer animationPlayer;
  private RemoteTransform2D cameraRig;

  public override void _Ready()
  {
    battery = maxBattery;
    lightDetector = GetNode<Area2D>("LightDetector");
    animationPlayer = GetNode<AnimationPlayer>("AnimationPlayer");
    cameraRig = GetNode<RemoteTransform2D>("Position2D/RemoteTransform2D");
  }

  public override void _PhysicsProcess(float delta)
  {
    ResetBatteryConsuptionRate();
    ApplyActor(delta);
  }

  public override void _Process(float delta)
  {
    UpdateAnimation();
    UpdateBattery(delta);
    CheckForLight();
  }

  public override void getUserInput()
  {
    input = new PlayerInput();

    if (Input.IsActionPressed("ui_right")) { input.direction += 1; }
    if (Input.IsActionPressed("ui_left")) { input.direction -= 1; }
    if (Input.IsActionPressed("ui_up")) { input.isJumping = true; }

    if (input.direction != 0) { consuptionBatteryRate += EnergyConsuptionRate.movement; }
    if (input.isJumping) { consuptionBatteryRate += EnergyConsuptionRate.jump; }
  }

  public void SetCameraOnRig(NodePath camera)
  {
    cameraRig.RemotePath = camera;
  }

  private void ResetBatteryConsuptionRate()
  {
    consuptionBatteryRate = EnergyConsuptionRate.idle;
  }

  private void UpdateAnimation()
  {
    if (velocity.x != 0 && animationPlayer.CurrentAnimation != "Walk") { animationPlayer.Play("Walk"); }
    if (velocity.x == 0 && animationPlayer.CurrentAnimation != "Idle") { animationPlayer.Play("Idle"); }
    if (!IsOnFloor() && velocity.y != 0) { animationPlayer.Play("Jump"); }
  }

  private void CheckForLight()
  {
    bool shouldRecharge = false;

    if (lightDetector.GetOverlappingAreas().Count > 0)
    {
      foreach (Area2D area in lightDetector.GetOverlappingAreas())
      {
        if (shouldRecharge) continue;

        var spaceState = GetWorld2d().DirectSpaceState;
        var result = spaceState.IntersectRay(area.GlobalPosition, GlobalPosition, new Godot.Collections.Array { area });

        if (result != null && result["collider"] is Player)
        {
          shouldRecharge = true;
        }
      }
    }

    isRecharging = shouldRecharge;
  }

  private void UpdateBattery(float delta)
  {
    if (isRecharging) { battery += rechargeBatteryRate * delta; }
    else { battery += -(consuptionBatteryRate * delta); }

    if (battery > maxBattery) { battery = maxBattery; }
    if (battery < 0) { battery = 0; }

    EmitSignal(nameof(OnUpdateBattery), battery, maxBattery);

    if (battery == 0) Die();
  }

  private void Die()
  {
    EmitSignal(nameof(OnDie));
    QueueFree();
  }
}
