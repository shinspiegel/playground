using Godot;
using System;
using System.Collections.Generic;

public class Door : StaticBody2D
{
  [Export] public bool isOpen = false;
  [Export] public bool followWhileOpening = false;
  [Export] public float delay = 0f;

  public AnimationPlayer animationPlayer;
  public Sprite sprite;
  public CollisionShape2D collisionShape2D;
  public Timer cameraDelay;

  private string animOpen = "Open";
  private string animClose = "Close";

  public override void _Ready()
  {
    base._Ready();
    animationPlayer = GetNode<AnimationPlayer>("AnimationPlayer");
    sprite = GetNode<Sprite>("Sprite");
    collisionShape2D = GetNode<CollisionShape2D>("CollisionShape2D");
    cameraDelay = GetNode<Timer>("CameraDelay");

    animationPlayer.Connect("animation_finished", this, nameof(Door.OnAnimationFinished));

    SetInitialState();
  }

  public void SetInitialState()
  {
    sprite.Frame = 0;
    collisionShape2D.Disabled = isOpen;
    sprite.Visible = !isOpen;
  }

  async public void Open()
  {
    if (!isOpen)
    {
      if (followWhileOpening)
      {
        ActivateCamera();

        if (delay > 0f)
        {
          cameraDelay.Start(delay);
          await ToSignal(cameraDelay, "timeout");
        }
      }

      animationPlayer.Play(animOpen);
      isOpen = true;
    }
  }

  public void Close()
  {
    if (isOpen)
    {
      animationPlayer.Play(animClose);
      isOpen = false;
    }
  }

  public void OnAnimationFinished(string animName)
  {
    if (animName == animOpen) { isOpen = true; }
    if (animName == animClose) { isOpen = false; }
    if (followWhileOpening) { DeactivateCamera(); }
  }

  private void ActivateCamera()
  {
    Player player = (Player)GetTree().CurrentScene.FindNode("Player");
    Camera2D camera = (Camera2D)GetTree().CurrentScene.FindNode("Camera2D");
    player.SetInputActive(false);
    player.SetPlayerCamera(false);
    camera.GlobalPosition = GlobalPosition;
  }

  private void DeactivateCamera()
  {
    Player player = (Player)GetTree().CurrentScene.FindNode("Player");
    player.SetPlayerCamera(true);
    player.SetInputActive(true);
  }
}
