using Godot;
using System;

public class Actor : KinematicBody2D
{
  [Export] public int speed = 120;
  [Export] public int jumpForce = 120;
  [Export] public int gravity = 300;
  [Export] public float floorFriction = 0.25f;
  [Export] public float airFriction = 0.05f;
  [Export] public float acceleration = 0.1f;

  public Vector2 velocity = new Vector2();
  public PlayerInput input = new PlayerInput();

  private float cuttingZero = 5f;
  private int facingDirection = 1;

  public virtual void ApplyActor(float delta)
  {
    getUserInput();

    ApplyVerticalForce();
    ApplyHorizontalForce();
    ApplyGravity(delta);
    CheckFlipInvert();

    ApplyMovement();
  }

  public virtual void getUserInput() { }

  public virtual void ApplyVerticalForce()
  {
    if (input.isJumping && IsOnFloor())
    {
      velocity.y = -jumpForce;
      input.isJumping = false;
    }
  }

  public virtual void ApplyHorizontalForce()
  {
    if (input.direction != 0)
    {
      velocity.x = Mathf.Lerp(velocity.x, (float)input.direction * (float)speed, acceleration);
    }
    else
    {
      float friction = IsOnFloor() ? floorFriction : airFriction;
      velocity.x = Mathf.Lerp(velocity.x, 0, friction);
    }
  }

  public virtual void ApplyMovement()
  {
    velocity = MoveAndSlide(velocity, Vector2.Up);
    if (Mathf.Abs(velocity.x) < cuttingZero) { velocity.x = 0; }
  }

  public virtual void ApplyGravity(float delta)
  {
    if (!IsOnFloor())
    {
      velocity.y += gravity * delta;
    }
  }

  public virtual void CheckFlipInvert()
  {
    if (velocity.x < 0 && facingDirection == 1)
    {
         Scale = new Vector2(-1, 1);
         facingDirection = -1;
    }

        if (velocity.x > 0 && facingDirection == -1)
    {
         Scale = new Vector2(-1, -1);
         facingDirection = 1;
    }
  }
}

