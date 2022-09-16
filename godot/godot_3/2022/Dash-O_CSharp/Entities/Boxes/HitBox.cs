using Godot;
using System;

namespace Entities
{
  public class HitBox : Area2D
  {
    [Export] public Damage damage;
  }
}