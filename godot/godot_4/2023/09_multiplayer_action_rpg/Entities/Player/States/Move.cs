using Godot;
using System;

public partial class Move : BaseState
{
	[Export] public Player player;
	[Export] public PlayerInput input;
	[Export] public PlayerAnimPlyer anim;

	public override void Apply(double delta)
	{
		player.ApplyGravity((float)delta);
		player.ApplyDirection(input.moveDir);
		player.ApplyFlip();

		if (
			(player.Velocity.X == 0.0f && input.moveDir == 0.0f) ||
			input.isJumping ||
			input.isRoll
			)
		{
			EndState();
		}
	}

	public override void Enter()
	{
		base.Enter();
		anim.Run();
	}

}
