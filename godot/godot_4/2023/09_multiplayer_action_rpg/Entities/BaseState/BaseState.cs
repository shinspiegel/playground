using Godot;

public abstract partial class BaseState : Node
{
	[Signal] public delegate void EndedEventHandler(string name);

	abstract public void Enter();
	abstract public void Exit();
	abstract public void Apply(double delta);
}