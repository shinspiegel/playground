using Godot;
using System;

public class HUD : CanvasLayer
{
  public TextureProgress staminaBar;
  public TextureProgress healthBar;
  public TextureProgress deepMetter;
  public TextureRect deepArrow;

  public float deepMin = 3;
  public float deepMax = 118;

  public override void _Ready()
  {
    healthBar = GetNode<TextureProgress>("VBoxContainer/HBoxContainer2/HealthBar");
    staminaBar = GetNode<TextureProgress>("VBoxContainer/StaminaBar");
    deepMetter = GetNode<TextureProgress>("HBoxContainer/DeepMetter");
    deepArrow = GetNode<TextureRect>("DeepMetterArrow");

    ResetHUD();
  }

  public void ResetHUD()
  {
    staminaBar.MaxValue = 29;
    staminaBar.Value = 29;

    healthBar.MaxValue = 48;
    healthBar.Value = 48;

    deepMetter.MaxValue = 118;
    deepMetter.Value = 0;

    deepArrow.RectPosition = new Vector2(deepArrow.RectPosition.x, deepMax);
  }

  public void OnDeepMetterChange(double value, double maxValue)
  {
    deepMetter.Value = (deepMetter.MaxValue * value) / maxValue;

    float deepArrowYPos = Mathf.Clamp(
      (float)((deepMax - (deepMax * value) / maxValue)) + 1f,
      deepMin,
      deepMax
    );

    deepArrow.RectPosition = new Vector2(
      deepArrow.RectPosition.x,
      deepArrowYPos
    );
  }

  public void OnStaminaChange(double value, double maxValue)
  {
    staminaBar.Value = (staminaBar.MaxValue * value) / maxValue;
  }

  public void OnHealthChange(double value, double maxValue)
  {
    healthBar.Value = (healthBar.MaxValue * value) / maxValue;
  }
}
