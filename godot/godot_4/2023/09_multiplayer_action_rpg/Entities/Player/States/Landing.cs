using Godot;
using System;

public partial class Landing : BaseState
{
	[Export] Player player;
	[Export] PlayerInput input;
	[Export] PlayerAnimPlyer anim;

	public override void _Ready()
	{
		base._Ready();
		anim.AnimationFinished += OnAnimFinished;
	}

	public override void Apply(double delta)
	{
		player.ApplyFlip();
		player.ApplyDirection(input.moveDir, 0.2f);
	}

	public override void Enter()
	{
		base.Enter();
		anim.JumpLand();
	}

	private void OnAnimFinished(StringName name)
	{
		if (name == "jump_land") { EndState(); }
	}
}
