using Godot;
using System;

namespace Entities.Player
{
  public class InputKeys : Resource
  {
    [Export] public string right = "right";
    [Export] public string left = "left";
    [Export] public string jump = "jump";
    [Export] public string roll = "roll";
    [Export] public string interact = "interact";
  }
}