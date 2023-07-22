using Godot;
using System;

public partial class Idle : BaseState
{
	[Export] Player Player;
	[Export] PlayerAnimPlyer Anim;

	public override void Apply(double delta)
	{
		Player.ApplyGravity((float)delta);
		// Player.checkJump();
		// Player.applyDirection();
		// Player.applyFlip();

	}

	public override void Enter()
	{
		Anim.Idle();
	}

	public override void Exit() { }
}
