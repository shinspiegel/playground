using Godot;
using System;

public class Player : Area2D
{
  [Export]
  public int speed = 400;
  private Vector2 screenSize;
  private Vector2 velocity = new Vector2();
  private AnimatedSprite animatedSprite;
  private CollisionShape2D collisionShape2D;

  [Signal]
  public delegate void Hit();

  public override void _Ready()
  {
    screenSize = GetViewport().Size;
    animatedSprite = GetNode<AnimatedSprite>("AnimatedSprite");
    collisionShape2D = GetNode<CollisionShape2D>("CollisionShape2D");
    Hide();
  }

  public override void _Process(float delta)
  {
    SetPlayerDirection();
    ApplyPlayerSpeed(delta);
    LimitPlayerMovement();
    ApplySpriteAnimation();
  }

  private void SetPlayerDirection()
  {
    velocity = Vector2.Zero;

    if (Input.IsActionPressed("ui_right")) { velocity.x += 1; }
    if (Input.IsActionPressed("ui_left")) { velocity.x -= 1; }
    if (Input.IsActionPressed("ui_down")) { velocity.y += 1; }
    if (Input.IsActionPressed("ui_up")) { velocity.y -= 1; }
  }

  private void ApplyPlayerSpeed(float delta)
  {
    if (velocity.Length() > 0)
    {
      velocity = velocity.Normalized() * speed;
      animatedSprite.Play();
    }
    else
    {
      animatedSprite.Stop();
    }

    Position += velocity * delta;
  }

  private void LimitPlayerMovement()
  {
    Position = new Vector2(
        x: Mathf.Clamp(Position.x, 0, screenSize.x),
        y: Mathf.Clamp(Position.y, 0, screenSize.y)
    );
  }

  private void ApplySpriteAnimation()
  {
    if (velocity.x != 0 || velocity.y != 0)
    {
      animatedSprite.Animation = "walk";
    }
    else
    {
      animatedSprite.Animation = "up";
    }

    if (velocity.y > 0)
    {
      animatedSprite.FlipV = true;
    }

    if (velocity.y < 0)
    {
      animatedSprite.FlipV = false;
    }
  }

  public void OnPlayerBodyEntered(PhysicsBody2D body)
  {
    Hide();
    EmitSignal("Hit");
    collisionShape2D.SetDeferred("disabled", true);
  }

  public void Start(Vector2 pos)
  {
    Position = pos;
    Show();
    GetNode<CollisionShape2D>("CollisionShape2D").Disabled = false;
  }
}
