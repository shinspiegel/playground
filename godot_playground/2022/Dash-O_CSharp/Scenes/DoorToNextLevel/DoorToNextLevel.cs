using Godot;
using System;

namespace Scenes
{
  public class DoorToNextLevel : Sprite
  {
    [Export] PackedScene nextLevel;
    [Export] bool isLocked = true;

    private Interactable interactable;
    private AnimationPlayer animationPlayer;

    public override void _Ready()
    {
      base._Ready();
      interactable = GetNode<Interactable>("Interactable");
      animationPlayer = GetNode<AnimationPlayer>("AnimationPlayer");

      interactable.Connect(
        nameof(Interactable.PlayerInteracted),
        this,
        nameof(DoorToNextLevel.OnPlayerInteracted)
      );

      SetLocked(isLocked);
    }

    public void Lock() { SetLocked(true); }
    public void Unlock() { SetLocked(false); }

    async public void OnPlayerInteracted(Entities.Player.Player player)
    {
      if (!isLocked)
      {
        player.input.Desactive();
        animationPlayer.Play("Open");
        await ToSignal(animationPlayer, "animation_finished");
        GetTree().ChangeSceneTo(nextLevel);
        player.input.Active();
      }
    }

    private void SetLocked(bool value)
    {
      isLocked = value;

      if (value)
      {
        animationPlayer.Play("Locked");
      }
      else
      {
        animationPlayer.Play("Unlocked");
      }
    }
  }
}