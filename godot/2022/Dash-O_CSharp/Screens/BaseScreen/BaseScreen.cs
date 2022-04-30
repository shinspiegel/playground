using Godot;
using System;

namespace Screens
{
  public class BaseScreen : Control
  {
    [Export] NodePath initialSelected;

    public override void _Ready()
    {
      if (initialSelected != null && GetNode<Control>(initialSelected) != null)
      {
        GetNode<Control>(initialSelected).GrabFocus();
      }
    }
  }
}