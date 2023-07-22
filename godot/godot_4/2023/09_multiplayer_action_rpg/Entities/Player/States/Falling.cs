using Godot;
using System;

public partial class Falling : BaseState
{
	[Export] Player Player;
	[Export] PlayerAnimPlyer Anim;

	public override void Apply(double delta)
	{
		Player.ApplyGravity((float)delta);
	}

	public override void Enter() { 
		Anim.JumpDown();
	}

	public override void Exit() { }
}
