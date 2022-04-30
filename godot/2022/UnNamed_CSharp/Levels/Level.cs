using Godot;
using System;

public class Level : Node2D
{
  public Player player;
  public HUD hud;
  public ParallaxBackground parallax;
  public DeepColorAdjust deepColorAdjust;

  public override void _Ready()
  {
    hud = GetNode<HUD>("HUD");
    player = GetNode<Player>("Player");
    parallax = GetNode<ParallaxBackground>("ParallaxBackground");
    deepColorAdjust = GetNode<DeepColorAdjust>("DeepColorAdjust");

    player.Connect(
      nameof(Player.StaminaChanged),
      hud,
      nameof(HUD.OnStaminaChange)
    );

    player.Connect(
      nameof(Player.HealthChanged),
      hud,
      nameof(HUD.OnHealthChange)
    );

    player.Connect(
      nameof(Player.PlayerDied),
      this,
      nameof(Level.OnPlayerDie)
    );
  }

  public override void _Process(float delta)
  {
    base._Process(delta);

    float deepColor = 0f;
    deepColor = 1 - Mathf.Clamp(player.GlobalPosition.y / 2500, 0.0f, 0.6f);
    deepColorAdjust.UpdateModulate(deepColor);

    float deepMetter = 0f;
    deepMetter = 1 - Mathf.Clamp(player.GlobalPosition.y / 2500, 0.0f, 1.0f);
    hud.OnDeepMetterChange(deepMetter, 1);
  }

  public void OnPlayerDie()
  {
    GetTree().ReloadCurrentScene();
  }
}
