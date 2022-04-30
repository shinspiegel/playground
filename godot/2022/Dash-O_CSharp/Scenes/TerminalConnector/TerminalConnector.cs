using Entities.Player;
using Godot;
using System;

namespace Scenes
{
  public class TerminalConnector : Node2D
  {
    [Export] public bool followDoor = false;
    [Export] public NodePath terminalPath;
    [Export] public NodePath connectionPath;
    [Export] public string callMethod = "";
    [Export] public string endSignal = "";

    private TerminalWithCommands terminal;
    private Godot.Node2D connection;
    private Player player;
    private PlayerCamera camera;

    private float delayMultiplier = 0.005f;

    public override void _Ready()
    {
      base._Ready();
      SetupCamera();
      Setup();
    }

    async public void OnTerminalSucceed()
    {
      if (followDoor && player != null && camera != null)
      {
        player.DesactiveCameraFollow();
        player.input.Desactive();

        camera.GlobalPosition = connection.GlobalPosition;

        float distance = player.GlobalPosition.DistanceTo(camera.GlobalPosition);
        float time = distance * delayMultiplier;

        await Utils.Wait.For(time, this);
      }

      if (callMethod != "" && connection.HasMethod(callMethod))
      {
        connection.Call(callMethod);
      }

      if (endSignal != "" && connection.HasSignal(endSignal))
      {
        await ToSignal(connection, endSignal);
      }

      if (followDoor && player != null && camera != null)
      {
        player.ActiveCameraFollow();
        player.input.Active();
      }
    }

    private void Setup()
    {
      connection = GetNode<Node2D>(connectionPath);
      terminal = GetNode<TerminalWithCommands>(terminalPath);

      terminal.Connect(
        nameof(TerminalWithCommands.Succeed),
        this,
        nameof(TerminalConnector.OnTerminalSucceed)
      );
    }

    private void SetupCamera()
    {
      player = (Player)GetTree().CurrentScene.FindNode("Player");
      camera = (PlayerCamera)GetTree().CurrentScene.FindNode("PlayerCamera2D");
    }
  }
}