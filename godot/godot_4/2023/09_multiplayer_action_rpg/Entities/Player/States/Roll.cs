using Godot;
using System;

public partial class Roll : BaseState
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
		player.ApplyDirection(player.GetFacing(), 0.5f);
	}

	public override void Enter()
	{
		base.Enter();
		anim.Roll();
	}

	private void onAnimFinished(StringName name)
	{
		if (name == "roll")
		{
			EndState();
		}
	}
}
