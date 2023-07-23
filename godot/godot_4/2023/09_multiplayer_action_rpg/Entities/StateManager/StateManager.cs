using Godot;
using Godot.Collections;

public partial class StateManager : Node
{
	[Signal] public delegate void StateFinishedEventHandler(string name);

	[Export] public Dictionary<string, BaseState> states = new();
	[Export] public BaseState initial;
	[Export] public BaseState current;

	public override void _Ready()
	{
		base._Ready();
		LoadStates();
		LoadInitialState();
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

		current?.Exit();

		current = states[next];
		current.Enter();
	}

	public string CurrentName()
	{
		return current.Name;
	}

	private void LoadInitialState()
	{
		if (initial is not null and BaseState)
		{
			current = initial;
		}
		else if (GetChildCount() > 0)
		{
			foreach (var child in GetChildren())
			{
				if (child is BaseState state)
				{
					current = state;
					return;
				}
			}
		}
	}

	private void LoadStates()
	{
		foreach (var child in GetChildren())
		{
			if (child is BaseState state)
			{
				states[child.Name] = state;
				states[child.Name].Ended += OnStateFinish;
			}
		}
	}

	private void OnStateFinish(string name)
	{
		EmitSignal(SignalName.StateFinished, name);
	}
}
