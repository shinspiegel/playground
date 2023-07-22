using Godot;
using System;

public partial class PlayerData : Resource
{
	[ExportGroup("Level")]
	[Export] public int level = 1;
	[Export] public int experience = 0;

	[ExportGroup("Attributes")]
	[Export] public int attack = 0;
	[Export] public int defense = 0;
	[Export] public int agility = 0;

	[ExportGroup("Internal Data")]
	[Export] public float speed = 300.0f;
	[Export] public float jumpForce = -400.0f;
	[Export] public float gravity = ProjectSettings.GetSetting("physics/2d/default_gravity").AsSingle();
}
