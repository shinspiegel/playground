using Godot;
using System;

public partial class PlayerAnimPlyer : AnimationPlayer
{
	public void Idle() { Play("idle"); }
	public void Run() { Play("run"); }
	public void JumpUp() { Play("jump_up"); }
	public void JumpDown() { Play("jump_down"); }
	public void JumpLand() { Play("jump_land"); }
}
