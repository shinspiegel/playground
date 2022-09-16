using Godot;
using System;

public class Player : KinematicBody2D
{
  [Signal] public delegate void StaminaChanged(double stamina, double maxStamina);
  [Signal] public delegate void HealthChanged(double health, double maxHealth);
  [Signal] public delegate void PlayerDied();

  [Export] public int speed = 120;
  [Export] public int jumpForce = 160;
  [Export] public int gravity = 400;
  [Export] public float acceleration = 0.1f;
  [Export] public float friction = 0.25f;
  [Export] public float airFriction = 0.05f;
  [Export] public NodePath cameraPath;

  public Vector2 motion = new Vector2();
  public int facingDirection = 1;
  public bool enableFlipOnMove = true;
  [Export] public float stamina;
  public float maxStamina = 10f;
  public float staminaConsumeRate = 10f;
  public float staminaRecoverRate = 10f;
  [Export] public float health;
  public float maxHealth = 100f;
  [Export] public float fallDamageAccumulator = 0f;
  public float fallDamageRate = 10f;

  public AnimationPlayer animationPlayer;
  public PlayerInput input;
  public StateManager stateManager;
  public Timer coyoteJumpTimer;
  public RemoteTransform2D cameraRig;
  public RayCast2D wallJumpCheck;
  public Particles2D wallParticles;
  public HurtBox hurtBox;
  public RayCast2D floorCheck;
  public PickableRange pickableRange;
  public AudioStreamPlayer audioPlayerJump;
  public AudioStreamPlayer audioPlayerHurt;

  public override void _Ready()
  {
    base._Ready();
    animationPlayer = GetNode<AnimationPlayer>("AnimationPlayer");

    input = GetNode<PlayerInput>("PlayerInput");

    stateManager = GetNode<StateManager>("StateManager");
    coyoteJumpTimer = GetNode<Timer>("CoyoteJumpTimer");
    wallJumpCheck = GetNode<RayCast2D>("WallJumpCheck");
    cameraRig = GetNode<RemoteTransform2D>("CameraPos/CameraRig");
    wallParticles = GetNode<Particles2D>("WallPaticles");
    hurtBox = GetNode<HurtBox>("HurtBox");
    floorCheck = GetNode<RayCast2D>("FloorCheck");
    pickableRange = GetNode<PickableRange>("PickableRange");
    audioPlayerJump = GetNode<AudioStreamPlayer>("Sounds/AudioJump");
    audioPlayerHurt = GetNode<AudioStreamPlayer>("Sounds/AudioHurt");

    ResetParticles();
    ResetStamina();
    ResetHealth();
    SetCameraToPlayer();
    SetPickableRange();
    SetupHurtBox();
  }

  public override void _PhysicsProcess(float delta)
  {
    base._PhysicsProcess(delta);
    CheckFlip();
    stateManager.ApplyState(delta);
    ApplyMotion();
    ApplyFallDamage(delta);
  }

  public void ApplyMotion()
  {
    motion = MoveAndSlide(motion, Vector2.Up);
  }

  public bool IsGrounded()
  {
    if (IsOnFloor()) { return true; }
    if (floorCheck.IsColliding()) { return true; }
    return false;
  }

  public bool IsWalled()
  {
    return wallJumpCheck.IsColliding();
  }

  public void ApplyGravity(float delta, float multiplier = 1f)
  {
    if (!IsGrounded() && coyoteJumpTimer.TimeLeft <= 0)
    {
      motion.y += gravity * delta * multiplier;
    }
  }

  public void ApplyHorizontalForce()
  {
    if (input.direction.x != 0)
    {
      motion.x = Mathf.Lerp(motion.x, input.direction.x * speed, acceleration);
    }
    else
    {
      if (IsGrounded())
      {
        motion.x = Mathf.Lerp(motion.x, 0, friction);
      }
      else
      {
        motion.x = Mathf.Lerp(motion.x, 0, airFriction);
      }
    }
  }

  public void ApplyJump()
  {
    if (
      input.jump &&
      stamina > 0 &&
      (IsGrounded() || coyoteJumpTimer.TimeLeft > 0)
    )
    {
      audioPlayerJump.Play();
      coyoteJumpTimer.Stop();
      motion.y = -jumpForce;
    }
  }

  public void ApplyCoyoteTimer()
  {
    if (IsGrounded() && coyoteJumpTimer.TimeLeft <= 0)
    {
      coyoteJumpTimer.Start();
    }
  }

  public void ApplyWallJump()
  {
    if (
      input.jump &&
      IsWalled() &&
      !IsGrounded()
    )
    {
      audioPlayerJump.Play();
      motion.x += jumpForce * (facingDirection * -1);
      motion.y = -(jumpForce * 0.75f);
    }
  }

  public void SetInputActive(bool value = true)
  {
    if (!value) { input.Reset(); }
    input.isActive = value;
  }

  public void OnReceiveDamage(HitBox hit, Damage damage)
  {
    if (stateManager.currentState.Name != PlayerContants.stateHit)
    {
      stateManager.ChangeState(PlayerContants.stateHit);
      stateManager.SendMessage<HitBox>(hit, Hit.HitObjectMessage);
      ApplyDamage(hit.damage);
    }
  }

  public void ApplyHitMotion(HitBox hit)
  {
    Vector2 hitForceDirection = new Vector2(
      x: hit.GlobalPosition.x - GlobalPosition.x < 0 ? 1 : -1,
      y: hit.GlobalPosition.y - GlobalPosition.y < -16 ? 1 : -1
    );

    motion.x += (hit.damage.horizontalForce) * hitForceDirection.x;
    motion.y += (hit.damage.verticalForce) * hitForceDirection.y;
  }

  public void ResetStamina()
  {
    UpdateStamina(maxStamina, 1f);
  }

  public void UpdateStamina(float amount, float delta)
  {
    float deltaValue = amount * delta;

    if (stamina + deltaValue < 0)
    {
      stamina = 0;
    }
    else if (stamina + deltaValue > maxStamina)
    {
      stamina = maxStamina;
    }
    else
    {
      stamina += deltaValue;
    }

    EmitSignal(nameof(Player.StaminaChanged), (double)stamina, (double)maxStamina);
  }

  public void ConsumeStamina(float delta)
  {
    UpdateStamina(-staminaConsumeRate, delta);
  }

  public void RecoverStamina(float delta)
  {
    if (IsGrounded())
    {
      UpdateStamina(staminaRecoverRate, delta);
    }
  }

  public void ResetHealth()
  {
    UpdateHealth(maxHealth);
  }

  public void UpdateHealth(float value)
  {
    if (value < 0)
    {
      audioPlayerHurt.Play();
    }

    if (health + value < 0)
    {
      health = 0;
      EmitSignal(nameof(Player.PlayerDied));
    }
    else if (health + value > maxHealth)
    {
      health = maxHealth;
    }
    else
    {
      health += value;
    }

    EmitSignal(nameof(Player.HealthChanged), (double)health, (double)maxHealth);
  }

  public void ApplyFallDamage(float delta)
  {
    float fallThreshold = 5f;

    if (IsGrounded())
    {
      if (fallDamageAccumulator > fallThreshold)
      {
        ApplyDamage(fallDamageAccumulator - fallThreshold);
      }

      fallDamageAccumulator = 0f;
    }

    if (stamina > 0 && IsWalled())
    {
      fallDamageAccumulator = 0f;
    }

    if (motion.y > 0)
    {
      if (stamina == 0 || !IsGrounded() || !IsWalled())
      {
        fallDamageAccumulator += fallDamageRate * delta;
      }
    }
  }

  public void ApplyDamage(float damage)
  {
    UpdateHealth(-damage);
  }

  public void ApplyDamage(Damage damage)
  {
    UpdateHealth(-((float)damage.amount));
  }

  public void RecoverHealth(int heal)
  {
    UpdateHealth((float)heal);
  }

  public void OnPickItem(PickableItem item)
  {
    if (item is ItemAnkh)
    {
      GD.Print("Is ank");
    }

    if (item is HealthPickup)
    {
      var healthPickup = (HealthPickup)item;
      RecoverHealth(healthPickup.health);
    }
  }

  public void SetPlayerCamera(bool value)
  {
    cameraRig.UpdatePosition = value;
    cameraRig.UpdateScale = value;
    cameraRig.UpdateScale = value;
  }

  private void CheckFlip()
  {
    if (enableFlipOnMove && motion.x != 0)
    {
      if (motion.x > 0 && facingDirection == -1)
      {
        Scale = new Vector2(x: -1, y: -1);
        facingDirection = 1;
      }

      if (motion.x < 0 && facingDirection == 1)
      {
        Scale = new Vector2(x: -1, y: 1);
        facingDirection = -1;
      }
    }
  }

  private void ResetParticles()
  {
    wallParticles.Emitting = false;
  }

  private void SetupHurtBox()
  {
    hurtBox.Connect(
      nameof(HurtBox.DamageReceived),
      this,
      nameof(Player.OnReceiveDamage)
    );
  }

  private void SetCameraToPlayer()
  {
    Camera2D cameraItem = GetNode<Camera2D>(cameraPath);
    // Needs to set one extra parent on this path, 
    // otherwise camera will not take the right camera item.
    cameraRig.RemotePath = "../../" + cameraPath;
  }

  private void SetPickableRange()
  {
    pickableRange.Connect(
      nameof(PickableRange.ItemPickedUp),
      this,
      nameof(Player.OnPickItem)
    );
  }
}
