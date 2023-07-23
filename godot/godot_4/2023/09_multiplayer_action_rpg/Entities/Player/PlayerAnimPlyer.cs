using System;
using Godot;

public partial class PlayerAnimPlyer : AnimationPlayer
{
	public void Idle() { Play("idle"); }

	public void Run() { Play("run"); }

	public void JumpUp() { Play("jump_up"); }

	public void JumpDown() { Play("jump_down"); }

	public void JumpLand() { Play("jump_land"); }

	public void Roll() { Play("roll"); }

	public void Hit() { Play("hit"); }
}
