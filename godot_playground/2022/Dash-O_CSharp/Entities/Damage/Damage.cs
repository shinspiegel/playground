using Godot;
using System;

namespace Entities
{
  public class Damage : Resource
  {
    [Export] public int amount = 1;
    [Export] public float horizontalForce = 100;
    [Export] public float verticalForce = 20;

    public Damage() { }

    public Damage(float damage)
    {
      amount = Mathf.FloorToInt(damage);
    }
  }
}