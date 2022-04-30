using Godot;
using System;

namespace State
{
  public class BaseState : Node2D
  {
    [Signal] public delegate void StateFinished(string nextState);

    public virtual void OnProccess(float delta) { }

    public virtual void OnEnter() { }

    public virtual void OnExit() { }

    public virtual void Message<T>(T message, string name = "UnNamed") { }

    public virtual void CheckChangeState() { }

    public virtual void ChangeState(string state)
    {
      EmitSignal(nameof(BaseState.StateFinished), state);
    }
  }
}