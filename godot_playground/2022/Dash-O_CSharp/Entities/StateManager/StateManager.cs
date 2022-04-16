using Godot;
using System;
using System.Collections.Generic;

namespace State
{
  public class StateManager : Node2D
  {
    [Signal] public delegate void StateChanged(string name);

    [Export] public NodePath initialStatePath;

    public Dictionary<string, BaseState> stateList = new Dictionary<string, BaseState>();
    public BaseState currentState;
    public BaseState initialState;

    public async override void _Ready()
    {
      await ToSignal(GetParent(), "ready");

      initialState = GetNode<BaseState>(initialStatePath);
      LoadAllStates();
      GetInitialState();
    }

    public void ApplyState(float delta)
    {
      currentState.OnProccess(delta);
    }

    public void ChangeState(string stateName)
    {
      if (currentState != null && currentState.Name != stateName)
      {
        BaseState nextState = stateList[stateName];

        currentState.OnExit();
        currentState = nextState;
        currentState.OnEnter();

        EmitSignal(nameof(StateManager.StateChanged), stateName);
      }
    }

    public void OnStateFinished(string nextState)
    {
      ChangeState(nextState);
    }

    public void SendMessage<T>(T message, string name = "UnNamed")
    {
      currentState.Message<T>(message, name);
    }

    public void SendMessage(string name)
    {
      currentState.Message<string>(name, name);
    }

    private void LoadAllStates()
    {
      foreach (Node item in GetChildren())
      {
        if (item is BaseState)
        {
          BaseState state = (BaseState)item;
          state.Connect(
            nameof(BaseState.StateFinished),
            this,
            nameof(StateManager.OnStateFinished)
          );
          stateList.Add(state.Name, state);
        }
      }
    }

    private void GetInitialState()
    {
      BaseState nextState = stateList[initialState.Name];

      currentState = nextState;
      currentState.OnEnter();

      EmitSignal(nameof(StateManager.StateChanged), initialState.Name);
    }
  }
}