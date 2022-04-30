using Godot;
using State;
using System;

namespace Entities.Player
{
  public class Player : KinematicBody2D
  {
    [Signal] public delegate void PlayerDied();
    [Signal] public delegate void HitPointsChanged(float hp, float max);
    [Signal] public delegate void StateChanged(string name);

    [Export] public Resources.FloatStat hitPoints;
    [Export] public StatesList stateList;
    [Export] public AnimationList animationList;
    [Export] public Movement movement;
    [Export] public NodePath cameraPath;

    public AnimationPlayer animationPlayer;
    public Input input;
    public StateManager stateManager;
    public RemoteTransform2D cameraRig;
    public HurtBox hurtBox;
    public Timer invincibilityTime;
    public RayCast2D groundFrontRay;
    public RayCast2D groundBackRay;

    public override void _Ready()
    {
      base._Ready();
      animationPlayer = GetNode<AnimationPlayer>("AnimationPlayer");
      input = GetNode<Input>("Input");
      stateManager = GetNode<StateManager>("StateManager");
      cameraRig = GetNode<RemoteTransform2D>("CameraPos/CameraRig");
      hurtBox = GetNode<HurtBox>("HurtBox");
      invincibilityTime = GetNode<Timer>("InvincibilityTime");
      groundFrontRay = GetNode<RayCast2D>("Sensor/GroundFront");
      groundBackRay = GetNode<RayCast2D>("Sensor/GroundBack");

      SetupStateManager();
      SetupHipPoints();
      SetCameraToPlayer();
      SetupHurtBox();
    }

    public override void _PhysicsProcess(float delta)
    {
      base._PhysicsProcess(delta);
      movement.CheckFlip(this);
      stateManager.ApplyState(delta);
      movement.ApplyMotion(this);
    }

    public void ActiveCameraFollow() { SetCameraUpdate(true); }
    public void DesactiveCameraFollow() { SetCameraUpdate(false); }


    public void OnReceiveDamage(HitBox hit, Damage damage)
    {
      if (invincibilityTime.TimeLeft <= 0)
      {
        invincibilityTime.Start();
        UpdateHitpoints(-hit.damage.amount);

        if (hitPoints.current > 0)
        {
          stateManager.ChangeState(stateList.hit);
          stateManager.SendMessage<HitBox>(hit);
        }
        else
        {
          stateManager.ChangeState(stateList.die);
        }
      }
    }

    public void OnHitPointsChanged(float current, float min, float max)
    {
      EmitSignal(nameof(Player.HitPointsChanged), current, max);
    }

    public void UpdateHitpoints(float value)
    {
      hitPoints.ChangeBy(value);
    }

    public void OnStateChange(string name)
    {
      EmitSignal(nameof(Player.StateChanged), name);
    }

    public bool IsGrounded()
    {
      return groundFrontRay.IsColliding() || groundBackRay.IsColliding();
    }

    public void SetInputActive(bool value = true)
    {
      input.SetActive(value);
    }

    public void SetEnableFlip(bool value = true)
    {
      movement.SetEnableFlip(value);
    }

    private void SetupHurtBox()
    {
      hurtBox.Connect(
        nameof(HurtBox.DamageReceived),
        this,
        nameof(Player.OnReceiveDamage)
      );
    }

    private void SetupHipPoints()
    {
      hitPoints.Reset();
      hitPoints.Connect(
        nameof(Resources.FloatStat.Changed),
        this,
        nameof(Player.OnHitPointsChanged)
      );
    }

    private void SetupStateManager()
    {
      stateManager.Connect(
        nameof(StateManager.StateChanged),
        this,
        nameof(Player.OnStateChange)
      );
    }

    private void SetCameraToPlayer()
    {
      if (cameraPath != null)
      {
        Camera2D cameraItem = GetNode<Camera2D>(cameraPath);

        // Needs to set one extra parent on this path, 
        // otherwise camera will not take the right camera item.
        cameraRig.RemotePath = "../../" + cameraPath;
      }
    }

    private void SetCameraUpdate(bool value = true)
    {
      cameraRig.UpdatePosition = value;
      cameraRig.UpdateRotation = value;
      cameraRig.UpdateScale = value;
    }
  }
}