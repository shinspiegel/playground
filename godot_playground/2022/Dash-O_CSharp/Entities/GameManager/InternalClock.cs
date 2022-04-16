using Godot;
using System;

namespace Entities
{
  public class InternalClock : Node2D
  {
    [Signal] public delegate void OutOfTime();
    [Signal] public delegate void TimeChanged(int min, int sec);

    [Export] public int minutes = 0;
    [Export] public int seconds = 0;

    public Timer timer;

    public override void _Ready()
    {
      base._Ready();
      timer = GetNode<Timer>("Timer");
      timer.Connect("timeout", this, nameof(InternalClock.OnTimeOut));
      timer.Start();
    }

    public void SetTime(int min, int sec)
    {
      minutes = min;
      seconds = sec;
      EmitSignal(nameof(InternalClock.TimeChanged), minutes, seconds);
    }

    private void OnTimeOut()
    {
      if (minutes <= 0 && seconds <= 0)
      {
        EmitSignal(nameof(InternalClock.OutOfTime));
        return;
      }

      seconds -= 1;

      if (seconds <= 0 && minutes > 0)
      {
        minutes -= 1;
        seconds = 60;
      }

      EmitSignal(nameof(InternalClock.TimeChanged), minutes, seconds);
      timer.Start();
    }
  }
}