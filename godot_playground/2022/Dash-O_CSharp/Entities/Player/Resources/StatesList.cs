using Godot;
using System;

namespace Entities.Player
{
  public class StatesList : Resource
  {
    [Export] public string run = "Run";
    [Export] public string idle = "Idle";
    [Export] public string hit = "Hit";
    [Export] public string jump = "Jump";
    [Export] public string falling = "Falling";
    [Export] public string roll = "Roll";
    [Export] public string die = "Die";
  }
}