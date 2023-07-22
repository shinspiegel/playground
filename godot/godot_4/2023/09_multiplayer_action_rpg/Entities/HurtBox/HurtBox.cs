using Godot;
using System;

public partial class HurtBox : Area2D
{
	[Signal] public delegate void HitEventHandler();

	public override void _Ready()
	{
		base._Ready();
		AreaEntered += OnAreaEnter;
	}

	private void OnAreaEnter(Area2D area)
	{
		if (area is HitBox)
		{
			EmitSignal(SignalName.Hit);
		}
	}
}
