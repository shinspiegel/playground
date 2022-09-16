using Godot;
using System;

namespace Entities
{
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
}
