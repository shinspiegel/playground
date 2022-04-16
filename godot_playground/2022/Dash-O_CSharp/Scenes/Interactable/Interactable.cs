using Entities.Player;
using Godot;
using Godot.Collections;
using System;

namespace Scenes
{
  public class Interactable : Node2D
  {
    [Signal] public delegate void PlayerEntered();
    [Signal] public delegate void PlayerExited();
    [Signal] public delegate void PlayerInteracted(Player player);

    public AnimationPlayer animationPlayer;
    public Player player;

    public override void _Ready()
    {
      base._Ready();
      SetupAndResetAnimation();
      SetupConnections();
    }

    public override void _Process(float delta)
    {
      base._Process(delta);
      if (player != null) { CheckPlayerInteraction(); }
    }

    public void CheckPlayerInteraction()
    {
      if (player.input.interact)
      {
        EmitSignal(nameof(Interactable.PlayerInteracted), player);
        OnPlayerExit(player);
      }
    }

    public void OnPlayerEntered(Node body)
    {
      if (body is Player)
      {
        player = body as Player;
        animationPlayer.Play(name: "Animate", fromEnd: false);
        EmitSignal(nameof(Interactable.PlayerEntered));
      }
    }

    public void OnPlayerExit(Node body)
    {
      if (body is Player)
      {
        player = null;

        if (animationPlayer.CurrentAnimationPosition != 0f)
        {
          animationPlayer.PlayBackwards(name: "Animate");
        }

        EmitSignal(nameof(Interactable.PlayerExited));
      }
    }

    private void SetupConnections()
    {
      Connect("body_entered", this, nameof(Interactable.OnPlayerEntered));
      Connect("body_exited", this, nameof(Interactable.OnPlayerExit));
    }

    private void SetupAndResetAnimation()
    {
      animationPlayer = GetNode<AnimationPlayer>("AnimationPlayer");
      animationPlayer.CurrentAnimation = "Animate";
      animationPlayer.Stop();
      animationPlayer.Seek(0f, true);
    }
  }
}