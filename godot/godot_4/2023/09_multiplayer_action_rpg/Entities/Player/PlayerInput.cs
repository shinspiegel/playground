using Godot;
using Godot.Collections;

public partial class PlayerInput : Node
{
	[Export] public bool isJumping = false;
	[Export] public float moveDir = 0.0f;

	public override void _PhysicsProcess(double delta)
	{
		base._PhysicsProcess(delta);
		CalculateDirection();
		UpdateJump();
	}

	private void UpdateJump()
	{
		isJumping = Input.IsActionPressed("ui_accept");
	}

	private void CalculateDirection()
	{
		moveDir = Input.GetActionStrength("ui_right") - Input.GetActionStrength("ui_left");
	}
}
