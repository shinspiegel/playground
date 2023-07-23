using Godot;

public partial class HurtBox : Area2D
{
	[Signal] public delegate void HitEventHandler();

	[Export(PropertyHint.Range, "0.0, 10.0, 0.1")] public float colddown = 0.5f;

	private Timer colddownTimer;

	public override void _Ready()
	{
		base._Ready();
		colddownTimer = GetNode<Timer>("Colddown");
		AreaEntered += OnAreaEnter;
	}

	private void OnAreaEnter(Area2D area)
	{
		if (area is HitBox && colddownTimer.TimeLeft <= 0)
		{
			colddownTimer.Start(colddown);
			EmitSignal(SignalName.Hit);
		}
	}
}
