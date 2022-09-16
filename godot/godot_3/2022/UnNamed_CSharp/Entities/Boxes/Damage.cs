using Godot;
using System;

public class Damage : Resource
{
  [Export] public int amount = 1;
  [Export] public float horizontalForce = 50;
  [Export] public float verticalForce = 10;

  public Damage() { }

  public Damage(float damage)
  {
    amount = Mathf.FloorToInt(damage);
  }
}