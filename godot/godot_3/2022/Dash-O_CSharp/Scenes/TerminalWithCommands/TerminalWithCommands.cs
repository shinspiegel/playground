using Godot;
using Scenes;
using System;

namespace Scenes
{
  public class TerminalWithCommands : Node2D
  {
    [Signal] public delegate void Succeed();

    [Export] public int inputSize = 2;
    [Export] public NodePath interactablePath;
    [Export] public NodePath commandInputPath;
    [Export] public NodePath terminalPath;
    [Export] public Entities.Damage damage;

    public Interactable interactable;
    public CommandInput commandInput;
    public Terminal terminal;
    public Entities.Player.Player player;

    public override void _Ready()
    {
      base._Ready();
      interactable = GetNode<Interactable>(interactablePath);
      commandInput = GetNode<CommandInput>(commandInputPath);
      terminal = GetNode<Terminal>(terminalPath);
      terminal.Desactivate();

      commandInput.SetInputSize(inputSize);

      interactable.Connect(
        nameof(Interactable.PlayerInteracted),
        this,
        nameof(TerminalWithCommands.OnPlayerActivateTerminal)
      );

      commandInput.Connect(nameof(
        CommandInput.ExitedTerminal),
        this,
        nameof(TerminalWithCommands.OnPlayerExitedTerminal)
      );

      commandInput.Connect(nameof(
        CommandInput.InputMissed),
        this,
        nameof(TerminalWithCommands.OnInputMissed)
      );

      commandInput.Connect(nameof(
        CommandInput.Successful),
        this,
        nameof(TerminalWithCommands.OnPlayerCompleteCommands)
      );
    }

    public void OnPlayerActivateTerminal(Entities.Player.Player player)
    {
      this.player = player;
      this.player.input.Desactive();
      this.commandInput.Activate();
      this.terminal.Activate();
    }

    public void OnPlayerExitedTerminal()
    {
      this.commandInput.Deactivate();
      this.terminal.Desactivate();
      this.player.input.Active();
      this.player = null;
    }

    public void OnPlayerCompleteCommands()
    {
      EmitSignal(nameof(TerminalWithCommands.Succeed));
      OnPlayerExitedTerminal();
    }

    public void OnInputMissed()
    {
      Entities.HitBox hit = new Entities.HitBox();
      hit.GlobalPosition = GlobalPosition;
      hit.Position = Position;
      hit.damage = damage;
      player.OnReceiveDamage(hit, damage);
    }
  }
}

