using Godot;
using System;

public class Damage : Godot.Object
{
  public int amount = 1;

  public Damage() { }

  public Damage(int value)
  {
    this.amount = value;
  }
}