using Godot;
using System;

public class HUD : CanvasLayer
{
  [Export] public PackedScene messageScene;

  public TextureProgress batteryBar;
  public VBoxContainer messageContainer;
  public Label batteryLevelText;

  public override void _Ready()
  {
    batteryBar = GetNode<TextureProgress>("Base/HBoxContainer/TextureProgress");
    batteryLevelText = GetNode<Label>("Base/HBoxContainer/InfoBox/Amount");
    messageContainer = GetNode<VBoxContainer>("Base/HBoxContainer/MessageBox");
  }

  public void DisplayMessage(string text)
  {
    Message message = (Message)messageScene.Instance();
    message.Text = text;
    messageContainer.AddChild(message);
  }

  public void UpdateBateryLevel(float amount, float total)
  {
    batteryBar.Value = (double)amount;
    batteryBar.MaxValue = (double)total;
    batteryLevelText.Text = amount.ToString("0.0");
  }
}
