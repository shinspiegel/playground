using Godot;

public partial class BaseState : Node
{
	[Export] public bool debug = false;

	[Signal] public delegate void EndedEventHandler(string name);

	public virtual void Enter() { if (debug) GD.Print($"Entered::[{Name}]"); }

	public virtual void Exit() { if (debug) GD.Print($"Existed::[{Name}]"); }

	public virtual void Apply(double delta) { }

	public virtual void EndState() { EmitSignal(SignalName.Ended, Name); }

}