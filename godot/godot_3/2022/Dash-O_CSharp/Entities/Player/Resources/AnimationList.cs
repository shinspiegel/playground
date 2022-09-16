using Godot;
using System;

namespace Entities.Player
{
  public class AnimationList : Resource
  {
    [Export] public string falling = "Falling";
    [Export] public string idle = "Idle";
    [Export] public string jumpUp = "JumpUp";
    [Export] public string jumpPeak = "JumpPeak";
    [Export] public string roll = "Roll";
    [Export] public string run = "Run";
    [Export] public string hit = "Hit";
    [Export] public string death = "Death";
  }
}