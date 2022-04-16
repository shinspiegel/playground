using Godot;
using System;

public class PlayerInput : Node2D
{
  public bool isActive = true;
  public Vector2 direction = new Vector2();
  public bool jump = false;

  public override void _Process(float delta)
  {
    base._Process(delta);

    if (isActive)
    {
      Reset();
      CheckDirectionalKeys();
      CheckJumpKeys();
    }
  }

  public void Reset()
  {
    direction = Vector2.Zero;
    jump = false;
  }

  public void CheckDirectionalKeys()
  {
    float leftStr = Input.GetActionStrength(PlayerContants.inputRight);
    float rightStr = Input.GetActionStrength(PlayerContants.inputLeft);
    direction.x = leftStr - rightStr;
  }

  public void CheckJumpKeys()
  {
    if (Input.IsActionJustPressed(PlayerContants.inputJump))
    {
      jump = true;
    }
  }
}
