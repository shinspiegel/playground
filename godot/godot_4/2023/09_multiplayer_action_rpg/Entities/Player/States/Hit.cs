using System;
using Godot;

public partial class Hit : BaseState
{
	[Export] public Player player;
	[Export] public PlayerInput input;
	[Export] public PlayerAnimPlyer anim;
	[Export] public HurtBox hurtBox;

	public override void _Ready()
	{
		base._Ready();
		anim.AnimationFinished += OnAnimFinished;
	}

	public override void Apply(double delta)
	{
		base.Apply(delta);
		player.ApplyGravity((float)delta);
		player.ApplyDirection(player.GetFacing() * -1, 0.1f);
	}

	public override void Enter()
	{
		base.Enter();
		anim.Hit();
		player.ApplyJumpForce(0.5f);
	}

	public override void Exit()
	{
		base.Exit();
	}

	private void OnAnimFinished(StringName name)
	{
		if (name == "hit") { EndState(); }
	}
}
