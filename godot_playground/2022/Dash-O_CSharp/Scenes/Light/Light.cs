using Godot;
using Godot.Collections;
using System;
using Utils;

namespace Scenes
{
  public class Light : Node2D
  {
    [Export] public float delayOnFirst = 0f;
    [Export] public float timeOn = 3f;
    [Export] public float timeOff = 3f;
    [Export] public float timeFlicker = 1f;

    public Timer timer;
    public Timer flicker;
    public Particles2D particles2D;
    public Light2D light2D;

    private enum State { ON, OFF, FLICKER }
    private State currentState = State.ON;
    private bool lightSwith = true;

    private float energyOn = 1.2f;
    private float energyFlicker = 1.5f;

    public override void _Ready()
    {
      base._Ready();
      particles2D = GetNode<Particles2D>("Particles2D");
      light2D = GetNode<Light2D>("Light2D");

      flicker = GetNode<Timer>("Flicker");
      flicker.Connect("timeout", this, nameof(Light.FlickerTimeout));

      timer = GetNode<Timer>("Timer");
      timer.Connect("timeout", this, nameof(Light.OnTimeout));
      timer.Start(timeOn + delayOnFirst);

      SetLight(light: true, particles: true);
      light2D.Energy = energyOn;
      lightSwith = true;
    }

    public void OnTimeout()
    {
      switch (currentState)
      {
        case State.ON:
          //Will start the FLICKER
          currentState = State.FLICKER;
          light2D.Energy = energyFlicker;
          flicker.Start(GenericRandom.Float(0.03f, 0.1f));
          timer.Start(timeFlicker);
          SetLight(light: false, particles: false);
          break;

        case State.FLICKER:
          // WIll start the OFF
          currentState = State.OFF;
          light2D.Energy = energyOn + GenericRandom.Float(-1f, 1f);
          timer.Start(timeOff);
          SetLight(light: false, particles: false);
          break;

        case State.OFF:
          // Will start the ON
          currentState = State.ON;
          light2D.Energy = energyOn;
          timer.Start(timeOn);
          SetLight(light: true, particles: true);
          break;

        default:
          break;
      }
    }

    public void FlickerTimeout()
    {
      if (currentState == State.FLICKER)
      {
        SetLight(light: !lightSwith, particles: false);
        flicker.Start(GenericRandom.Float(0.03f, 0.1f));
      }
    }

    public void SetLight(bool light, bool particles)
    {
      light2D.Enabled = light;
      particles2D.Emitting = particles;
      lightSwith = light;
    }
  }
}