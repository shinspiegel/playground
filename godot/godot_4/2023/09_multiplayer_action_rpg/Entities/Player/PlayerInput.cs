using Godot;
using Godot.Collections;

public partial class PlayerInput : Node
{
	[Export] public float moveDir = 0.0f;
	[Export] public bool isJumping = false;
	[Export] public bool isRoll = false;

	public override void _PhysicsProcess(double delta)
	{
		base._PhysicsProcess(delta);
		CalculateDirection();
		UpdateJump();
		UpdateRoll();
	}

	private void CalculateDirection()
	{
		moveDir = Input.GetActionStrength("ui_right") - Input.GetActionStrength("ui_left");
	}

	private void UpdateJump()
	{
		isJumping = Input.IsActionPressed("ui_accept");
	}

	private void UpdateRoll()
	{
		isRoll = Input.IsActionPressed("ui_cancel");
	}
}
