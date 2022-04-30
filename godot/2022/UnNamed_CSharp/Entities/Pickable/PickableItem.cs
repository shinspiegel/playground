using Godot;
using System;

interface IPickableItem
{
  void PickUp();
}

public class PickableItem : Area2D, IPickableItem
{
  public void PickUp()
  {
    QueueFree();
  }
}
