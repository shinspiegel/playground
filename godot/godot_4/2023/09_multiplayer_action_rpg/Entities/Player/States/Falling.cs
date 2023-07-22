using Godot;
using System;

public partial class Falling : BaseState
{
	[Export] public Player player;
	[Export] public PlayerInput input;
	[Export] public PlayerAnimPlyer anim;

	public override void Apply(double delta)
	{
		player.ApplyGravity((float)delta);
		player.ApplyDirection(input.moveDir, 0.8f);
		player.ApplyFlip();
	}

	public override void Enter()
	{
		base.Enter();
		anim.JumpDown();
	}
}
