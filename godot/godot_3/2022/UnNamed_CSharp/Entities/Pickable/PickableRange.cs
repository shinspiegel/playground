using Godot;
using System;

public class PickableRange : Area2D
{
  [Signal] public delegate void ItemPickedUp(PickableItem itemObject);

  public override void _Ready()
  {
    Connect("area_entered", this, nameof(PickableRange.OnAreaEnter));
  }

  public void OnAreaEnter(Area2D area)
  {
    if (area is IPickableItem)
    {
      var pickable = (PickableItem)area;
      EmitSignal(nameof(PickableRange.ItemPickedUp), pickable);
      pickable.PickUp();
    }
  }
}
