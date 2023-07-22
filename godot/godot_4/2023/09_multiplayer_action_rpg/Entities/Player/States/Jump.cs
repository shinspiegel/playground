using Godot;
using System;

public partial class Jump : BaseState
{
	[Export] public Player player;
	[Export] public PlayerInput input;
	[Export] public PlayerAnimPlyer anim;

	public override void Apply(double delta)
	{
		player.ApplyGravity((float)delta);
		player.ApplyDirection(input.moveDir, 0.9f);
		player.ApplyFlip();

		if (player.Velocity.Y > 0) { EndState(); }
	}

	public override void Enter()
	{
		base.Enter();
		anim.JumpUp();
		player.ApplyJumpForce();
	}
}
