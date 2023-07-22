using Godot;
using System;

public partial class Landing : BaseState
{
	[Export] Player Player;
	[Export] PlayerAnimPlyer Anim;

	public override void _Ready()
	{
		base._Ready();
		Anim.AnimationFinished += onAnimFinished;
	}

	public override void Apply(double delta) { }

	public override void Enter()
	{
		Anim.JumpLand();
	}

	public override void Exit() { }

	private void onAnimFinished(StringName name)
	{
		GD.Print($"Finished::[{name}]");
	}
}
