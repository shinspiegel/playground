using Godot;
using Godot.Collections;

public partial class StateManager : Node
{
	[Signal] public delegate void StateFinishedEventHandler(string name);

	[Export] public Dictionary<string, BaseState> states = new Dictionary<string, BaseState>();
	[Export] public BaseState initial;
	[Export] public BaseState current;

	public override void _Ready()
	{
		base._Ready();
		loadStates();
		loadInitialState();
	}

	public void Apply(double delta)
	{
		if (current == null) return;
		current.Apply(delta);
	}

	public void Change(string next)
	{
		if (states[next] == null || CurrentName() == next)
		{
			return;
		}

		if (current != null)
		{
			current.Exit();
		}

		current = states[next];
		current.Enter();
	}

	public string CurrentName()
	{
		return current.Name;
	}

	private void loadInitialState()
	{
		if (initial != null && initial is BaseState)
		{
			current = initial;
		}
		else if (GetChildCount() > 0)
		{
			foreach (var child in GetChildren())
			{
				if (child is BaseState)
				{
					current = (BaseState)child;
					return;
				}
			}
		}
	}

	private void loadStates()
	{
		foreach (var child in GetChildren())
		{
			if (child is BaseState)
			{
				states[child.Name] = (BaseState)child;
				states[child.Name].Ended += onStateFinish;
			}
		}
	}

	private void onStateFinish(string name)
	{
		EmitSignal(SignalName.StateFinished, name);
	}
}
