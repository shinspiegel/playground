using Godot;
using State;
using System;

namespace Entities.Player
{
  public class PlayerState : BaseState
  {
    public Player player;
    public Movement movement;

    public override void _Ready()
    {
      base._Ready();
      player = (Player)GetParent().GetParent();
      movement = player.movement;
    }
  }
}