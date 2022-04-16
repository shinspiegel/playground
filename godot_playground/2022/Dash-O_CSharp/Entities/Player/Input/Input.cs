using Godot;
using System;

namespace Entities.Player
{
  public class Input : Node2D
  {
    [Export] InputKeys keys;

    public bool isActive = true;
    public Vector2 direction = new Vector2();
    public bool jump = false;
    public bool roll = false;
    public bool interact = false;

    public override void _PhysicsProcess(float delta)
    {
      base._PhysicsProcess(delta);
      if (isActive)
      {
        ResetDirectional();
        CheckDirectionalKeys();
      }
    }

    public override void _UnhandledInput(InputEvent inputEvent)
    {
      base._UnhandledInput(inputEvent);
      if (isActive)
      {
        CheckForKey(inputEvent, keys.jump, ref jump);
        CheckForKey(inputEvent, keys.roll, ref roll);
        CheckForKey(inputEvent, keys.interact, ref interact);
      }
    }

    public void Active() { SetActive(true); }
    public void Desactive() { SetActive(false); }

    public void SetActive(bool value)
    {
      ResetAll();
      isActive = value;
    }

    public void ResetAll()
    {
      ResetDirectional();
      ResetJump();
      ResetInteraction();
    }

    public void ResetDirectional() { direction = Vector2.Zero; }

    public void ResetJump() { jump = false; }

    public void ResetInteraction() { interact = false; }

    private void CheckDirectionalKeys()
    {
      float leftStr = Godot.Input.GetActionStrength(keys.right);
      float rightStr = Godot.Input.GetActionStrength(keys.left);
      direction.x = leftStr - rightStr;
    }

    private void CheckForKey(InputEvent inputEvent, string key, ref bool internalBool)
    {
      if (inputEvent.IsActionPressed(key)) { internalBool = true; }
      if (inputEvent.IsActionReleased(key)) { internalBool = false; }
    }
  }
}
