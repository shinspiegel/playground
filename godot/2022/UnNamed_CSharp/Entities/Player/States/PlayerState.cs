using Godot;
using System;

public class PlayerState : BaseState
{
  public Player player;

  public override void _Ready()
  {
    base._Ready();
    player = (Player)GetParent().GetParent();
  }
}
