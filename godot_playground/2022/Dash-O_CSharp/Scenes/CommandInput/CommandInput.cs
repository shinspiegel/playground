using Godot;
using Godot.Collections;
using System;
using Utils;

namespace Scenes
{
  public class CommandInput : Node2D
  {
    [Signal] public delegate void Successful();
    [Signal] public delegate void ExitedTerminal();
    [Signal] public delegate void InputMissed();

    [Export] public bool isActive = false;
    [Export] public int inputSize = 4;
    [Export] public Array<string> inputKeyList = new Array<string> { "ui_up", "ui_down", "ui_left", "ui_right" };
    [Export] public Array<PackedScene> inputSceneList = new Array<PackedScene>();

    public HBoxContainer container;
    public Tween tween;

    private bool isListeningKeys = false;

    public override void _Ready()
    {
      base._Ready();
      container = GetNode<HBoxContainer>("ActionsContainer");
      tween = GetNode<Tween>("Tween");
      tween.Connect(
        "tween_all_completed",
        this,
        nameof(CommandInput.OnCompleteAllTween)
      );
    }

    public override void _PhysicsProcess(float delta)
    {
      base._PhysicsProcess(delta);
      if (isActive)
      {
        ApplyCommand();
        CheckQuitInput();
        CheckIfSucceed();
      }
    }

    public void Activate()
    {
      AddRandomInputs();
      this.isActive = true;
    }

    public void Deactivate()
    {
      CleanInputs();
      this.isActive = false;
    }

    public void SetInputSize(int size)
    {
      inputSize = size;
    }

    private void ApplyCommand()
    {
      var action = GetCurrentAction();
      var correct = GetCurrentCorrectAction();

      if (action != null && correct != null)
      {
        if (action == correct)
        {
          OnCorrectAction();
        }
        else
        {
          OnIncorrectAction();
        }
      }
    }

    private void CheckIfSucceed()
    {
      if (container.GetChildCount() <= 0)
      {
        EmitSignal(nameof(CommandInput.Successful));
      }
    }

    private void OnCorrectAction()
    {
      if (container.GetChildCount() > 0)
      {
        var first = container.GetChildren()[0] as Node;
        container.RemoveChild(first);
      }
    }

    private void OnIncorrectAction()
    {
      EmitSignal(nameof(CommandInput.InputMissed));
    }

    private void OnCompleteAllTween()
    {
      isListeningKeys = true;
    }

    private void CheckQuitInput()
    {
      if (Godot.Input.IsActionJustPressed("ui_cancel"))
      {
        EmitSignal(nameof(CommandInput.ExitedTerminal));
      }
    }

    private string GetCurrentCorrectAction()
    {
      if (container.GetChildCount() > 0)
      {
        Node first = container.GetChildren()[0] as Node;

        for (int i = 0; i < inputSceneList.Count; i++)
        {
          if (first.Filename == inputSceneList[i].ResourcePath)
          {
            return inputKeyList[i];
          }
        }
      }
      return null;
    }

    private string GetCurrentAction()
    {
      if (isListeningKeys)
      {
        foreach (var key in inputKeyList)
        {
          if (Godot.Input.IsActionJustPressed(key))
          {
            return key;
          }
        }
      }
      return null;
    }

    private void ResetCommands()
    {
      CleanInputs();
      AddRandomInputs();
    }

    private void CleanInputs()
    {
      foreach (Node node in container.GetChildren())
      {
        container.RemoveChild(node);
      }

      isListeningKeys = false;
    }

    private void AddRandomInputs()
    {
      for (int i = 0; i < inputSize; i++)
      {
        int random = GenericRandom.Int(max: inputSceneList.Count - 1);

        TextureRect randomItem = inputSceneList[random].Instance() as TextureRect;
        randomItem.Modulate = new Color(0, 0, 0, 0);

        tween.InterpolateProperty(
          randomItem,
          "modulate",
          new Color(0, 0, 0, 0),
          new Color(1, 1, 1, 1),
          0.3f,
          Tween.TransitionType.Cubic,
          Tween.EaseType.InOut,
          i * 0.1f
        );

        container.AddChild(randomItem);
        tween.Start();
      }
    }
  }
}