using Godot;
using System;

public partial class PlayerData : Node
{
    [Export] public float Speed = 300.0f;
    [Export] public float JumpVelocity = -400.0f;
    [Export] public float gravity = ProjectSettings.GetSetting("physics/2d/default_gravity").AsSingle();
}
