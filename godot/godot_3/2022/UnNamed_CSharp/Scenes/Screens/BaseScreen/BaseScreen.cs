using Godot;
using System;

public class BaseScreen : Control
{
  [Export] NodePath initialSelected;

  public override void _Ready()
  {
    GetNode<Control>(initialSelected).GrabFocus();
  }
}
