using Godot;
using System;

public partial class Landing : BaseState
{
	[Export] Player player;
	[Export] PlayerAnimPlyer anim;

	public override void _Ready()
	{
		base._Ready();
		anim.AnimationFinished += onAnimFinished;
	}

	public override void Apply(double delta)
	{
		player.ApplyFlip();
		player.ApplyDirection();
	}

	public override void Enter()
	{
		base.Enter();
		anim.JumpLand();
	}

	private void onAnimFinished(StringName name)
	{
		if (name == "jump_land")
		{
			EmitSignal(SignalName.Ended, Name);
		}
	}
}
