using System;
using Godot;

public partial class Player : CharacterBody2D
{
	private const float Speed = 500.0f;

	private Vector2 direction = Vector2.Zero;
	private Vector2 velocity = Vector2.Zero;

	public override void _PhysicsProcess(double delta)
	{
		UpdateInternalVelocity();
		ApplyDirection();
		ApplyMovement();
	}

	private void UpdateInternalVelocity()
	{
		velocity = Velocity;
	}

	private void ApplyDirection()
	{
		direction = Input.GetVector("ui_left", "ui_right", "ui_up", "ui_down").Normalized();

		if (direction.X != 0)
		{
			velocity.X = direction.X * Speed;
		}
		else
		{
			velocity.X = Mathf.MoveToward(Velocity.X, 0, Speed);
		}

		if (direction.Y != 0)
		{
			velocity.Y = direction.Y * Speed;
		}
		else
		{
			velocity.Y = Mathf.MoveToward(Velocity.Y, 0, Speed);
		}
	}

	private void ApplyMovement()
	{
		Velocity = velocity;
		MoveAndSlide();
	}
}
