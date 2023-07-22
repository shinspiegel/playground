using Godot;
using Godot.Collections;

public partial class StateManager : Node
{
	[Signal] public delegate void StateFinishedEventHandler(string name);

	[Export] public Dictionary<string, BaseState> States = new Dictionary<string, BaseState>();
	[Export] public BaseState Initial;
	[Export] public BaseState Current;

	public override void _Ready()
	{
		base._Ready();
		loadStates();
		loadInitialState();
	}

	public void Apply(double delta)
	{
		if (Current == null) return;
		Current.Apply(delta);
	}

	public void Change(string next)
	{
		if (States[next] != null)
		{
			if (Current != null)
			{
				Current.Exit();
			}

			Current = States[next];
			Current.Enter();
		}
	}

	public string CurrentName()
	{
		return Current.Name;
	}

	private void loadInitialState()
	{
		if (Initial != null && Initial is BaseState)
		{
			Current = Initial;
		}
		else if (GetChildCount() > 0)
		{
			foreach (var child in GetChildren())
			{
				if (child is BaseState)
				{
					Current = (BaseState)child;
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
				States[child.Name] = (BaseState)child;
				States[child.Name].Ended += onStateFinish;
			}
		}
	}

	private void onStateFinish(string name)
	{
		EmitSignal(SignalName.StateFinished, name);
	}
}
