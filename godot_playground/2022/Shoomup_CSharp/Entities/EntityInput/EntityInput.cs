using Godot;
using System;

public class EntityInput : Resource
{
  [Export] public Vector2 direction;
  [Export] public bool shoot;
  [Export] public float holdFor;

  private EntityInput() { }

  public EntityInput(Vector2 dir = new Vector2(), float timer = 0.0f, bool shoot = false)
  {
    this.direction = dir;
    this.holdFor = timer;
    this.shoot = shoot;
  }

  public void Reset()
  {
    direction = Vector2.Zero;
    shoot = false;
  }
}