using Godot;
using System;

public partial class Move : BaseState
{
	[Export] PlayerAnimPlyer Anim;
	
	public override void Apply(double delta) { }

	public override void Enter() { 
		Anim.Run();
	}

	public override void Exit() { }
}
