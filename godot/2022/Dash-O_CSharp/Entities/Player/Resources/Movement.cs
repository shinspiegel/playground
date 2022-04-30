using Godot;
using System;

namespace Entities.Player
{
  public class Movement : Resource
  {
    [Export] public int speed = 140;
    [Export] public int jumpForce = 240;
    [Export] public int gravity = 350;
    [Export] public float acceleration = 0.1f;
    [Export] public float friction = 0.25f;
    [Export] public float airFriction = 0.025f;
    [Export] public int facingDirection = 1;
    [Export] public bool enableFlipOnMove = true;
    [Export] public Vector2 motion = Vector2.Zero;

    public void ResetMotion() { motion = Vector2.Zero; }
    public void ResetMotionY() { motion.y = 0f; }
    public void SetMotion(Vector2 motion) { this.motion = motion; }

    public bool IsFalling() { return motion.y > 0; }
    public void ApplyJumpForce() { motion.y = -jumpForce; }

    public void SetEnableFlip(bool value = true) { enableFlipOnMove = value; }

    public void ApplyMotion(Player player)
    {
      motion = player.MoveAndSlide(motion, Vector2.Up);
    }

    public void ApplyGravity(Player player, float delta, float multiplier = 1f)
    {
      if (!player.IsGrounded())
      {
        motion.y += gravity * delta * multiplier;
      }
    }

    public void ApplyHorizontalForce(Player player, float direction, float multiplier = 1f)
    {
      if (direction != 0)
      {
        motion.x = Mathf.Lerp(motion.x, direction * speed * multiplier, acceleration);
      }
      else
      {
        if (player.IsGrounded())
        {
          motion.x = Mathf.Lerp(motion.x, 0, friction);
        }
        else
        {
          motion.x = Mathf.Lerp(motion.x, 0, airFriction);
        }
      }
    }

    public void CheckFlip(Player player)
    {
      if (enableFlipOnMove && motion.x != 0)
      {
        if (motion.x > 0 && facingDirection == -1)
        {
          player.Scale = new Vector2(x: -1, y: -1);
          facingDirection = 1;
        }

        if (motion.x < 0 && facingDirection == 1)
        {
          player.Scale = new Vector2(x: -1, y: 1);
          facingDirection = -1;
        }
      }
    }
  }
}