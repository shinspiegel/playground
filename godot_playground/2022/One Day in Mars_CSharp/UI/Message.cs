using Godot;
using System;

public class Message : Label
{
  public void OnTimerOut() { QueueFree(); }
}
