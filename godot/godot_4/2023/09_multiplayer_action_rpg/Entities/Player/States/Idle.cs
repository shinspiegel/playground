using Godot;
using System;

public partial class Idle : BaseState
{
	[Export] Player player;
	[Export] PlayerInput input;
	[Export] PlayerAnimPlyer anim;

	public override void Apply(double delta)
	{
		player.ApplyGravity((float)delta);
		player.ApplyDirection(input.moveDir);
	}

	public override void Enter()
	{
		base.Enter();
		anim.Idle();
	}

}
