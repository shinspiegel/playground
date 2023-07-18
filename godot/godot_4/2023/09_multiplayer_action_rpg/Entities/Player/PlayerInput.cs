using Godot;
using Godot.Collections;

public partial class PlayerInput : Node
{
	[Export] public bool IsJumping = false;
	[Export] public Vector2 Direction = Vector2.Zero;

	[Export]
	Dictionary<string, StringName> KeyMapping = new Dictionary<string, StringName> {
		{ "left", new StringName("ui_left") },
		{ "right", new StringName("ui_right") },
		{ "up", new StringName("ui_up") },
		{ "down", new StringName("ui_down") },
		{ "jump", new StringName("ui_accept")},
	};

	public override void _PhysicsProcess(double delta)
	{
		base._PhysicsProcess(delta);
		CalculateDirection();
		UpdateJump();
	}

	private void UpdateJump()
	{
		IsJumping = Input.IsActionPressed(KeyMapping["jump"]);
	}

	private void CalculateDirection()
	{
		Direction = Input.GetVector(
			KeyMapping["left"], KeyMapping["right"],
			KeyMapping["up"], KeyMapping["down"]
		).Normalized();
	}
}
