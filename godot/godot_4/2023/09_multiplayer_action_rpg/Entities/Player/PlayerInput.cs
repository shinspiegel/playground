using Godot;

public partial class PlayerInput : Node
{
	[Export] public float moveDir = 0.0f;
	[Export] public bool isJumping = false;
	[Export] public bool isRoll = false;
	[Export] public bool isAttack = false;

	public override void _PhysicsProcess(double delta)
	{
		base._PhysicsProcess(delta);
		CalculateDirection();
		UpdateJump();
		UpdateRoll();
		UpdateAttack();
	}

	private void CalculateDirection()
	{
		moveDir = Input.GetActionStrength("right") - Input.GetActionStrength("left");
	}

	private void UpdateJump()
	{
		isJumping = Input.IsActionPressed("jump");
	}

	private void UpdateRoll()
	{
		isRoll = Input.IsActionPressed("roll");
	}

	private void UpdateAttack()
	{
		isAttack = Input.IsActionPressed("attack");
	}
}
