using Godot;
using System;

public class Actor : KinematicBody2D
{
  [Signal] public delegate void EntityDied();

  [Export] public int speed = 120;
  [Export] public float friction = 0.25f;
  [Export] public float acceleration = 0.1f;
  [Export] public PackedScene shootScene;
  [Export] public int hitPoints = 1;

  public Vector2 velocity = new Vector2();
  public EntityInput input = new EntityInput();
  public Position2D shootPosition;
  public Timer shootColdownTimer;
  public AnimationPlayer animationPlayer;
  public AudioStreamPlayer shootPlayer;

  public override void _Ready()
  {
    shootPosition = GetNode<Position2D>("ShootPosition");
    shootColdownTimer = GetNode<Timer>("ShootColdown");
    animationPlayer = GetNode<AnimationPlayer>("AnimationPlayer");
    shootPlayer = GetNode<AudioStreamPlayer>("ShootPlayer");
  }

  public virtual void ApplyActor()
  {
    GetUserInput();
    ApplyDirectionalForce();
    ApplyShoot();
    ApplyMovement();
  }

  public virtual void GetUserInput() { }

  public virtual void ApplyShoot()
  {
    if (input.shoot && shootColdownTimer.TimeLeft == 0.0f)
    {
      shootColdownTimer.Start();
      Shoot shoot = shootScene.Instance<Shoot>();
      shoot.GlobalPosition = shootPosition.GlobalPosition;
      GetParent().AddChild(shoot);

      shootPlayer.Play();
    }
  }

  public virtual void ApplyDirectionalForce()
  {
    if (input.direction.x != 0)
    {
      float finalVelocity = (float)input.direction.x * (float)speed;
      velocity.x = Mathf.Lerp(velocity.x, finalVelocity, acceleration);
    }
    else
    {
      velocity.x = Mathf.Lerp(velocity.x, 0, friction);
    }
  }

  public virtual void ApplyMovement()
  {
    velocity = MoveAndSlide(velocity, Vector2.Zero);
  }

  public virtual void TakeDamage(Damage damage)
  {
    hitPoints -= damage.amount;
    if (hitPoints < 1) { Die(); }
  }

  public virtual void Die()
  {
    EmitSignal(nameof(Actor.EntityDied));
    QueueFree();
  }
}
