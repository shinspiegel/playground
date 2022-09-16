using Godot;
using System;
using System.Threading.Tasks;

public class Spawner : Node2D
{
  [Signal] public delegate void SpawnTimeout();

  private Godot.Collections.Array<Position2D> positionList = new Godot.Collections.Array<Position2D>();

  public Timer spawnColdown;
  public Timer miniColdown;
  public Main main;

  public PackedScene downEnemyScene = ResourceLoader.Load("res://Entities/Enemies/DownShootDown.tscn") as PackedScene;
  public PackedScene speedEnemyScene = ResourceLoader.Load("res://Entities/Enemies/SpeedDown.tscn") as PackedScene;
  public PackedScene downWaitEnemyScene = ResourceLoader.Load("res://Entities/Enemies/DownWaitDown.tscn") as PackedScene;

  public override void _Ready()
  {
    spawnColdown = GetNode<Timer>("SpawnColdown");
    miniColdown = GetNode<Timer>("MiniColdown");

    positionList.Add(GetNode<Position2D>("Positions/Position2D0"));
    positionList.Add(GetNode<Position2D>("Positions/Position2D1"));
    positionList.Add(GetNode<Position2D>("Positions/Position2D2"));
    positionList.Add(GetNode<Position2D>("Positions/Position2D3"));
    positionList.Add(GetNode<Position2D>("Positions/Position2D4"));
    positionList.Add(GetNode<Position2D>("Positions/Position2D5"));
    positionList.Add(GetNode<Position2D>("Positions/Position2D6"));

    spawnColdown.Connect("timeout", this, nameof(Spawner.OnTimerOut));
  }

  public void SpawnOneEnemy(PackedScene enemyScene, int? option = null, int scoreValue = 0)
  {
    if (option == null) { option = GenericRandom.Int(max: 6); }

    SpawnEnemyScene(enemyScene, positionList[(int)option].GlobalPosition, scoreValue);
  }

  async public void SpawnTwoEnemies(PackedScene enemyScene, int? option = null, int scoreValue = 0)
  {
    if (option == null) { option = GenericRandom.Int(max: 3); }

    switch (option)
    {
      case 0:
        SpawnEnemyScene(enemyScene, positionList[0].GlobalPosition, scoreValue);
        SpawnEnemyScene(enemyScene, positionList[6].GlobalPosition, scoreValue);
        break;

      case 1:
        SpawnEnemyScene(enemyScene, positionList[1].GlobalPosition, scoreValue);
        SpawnEnemyScene(enemyScene, positionList[5].GlobalPosition, scoreValue);
        break;

      case 2:
        SpawnEnemyScene(enemyScene, positionList[2].GlobalPosition, scoreValue);
        SpawnEnemyScene(enemyScene, positionList[4].GlobalPosition, scoreValue);
        break;

      case 3:
        SpawnEnemyScene(enemyScene, positionList[3].GlobalPosition, scoreValue);
        await WaitFor(2f);
        SpawnEnemyScene(enemyScene, positionList[3].GlobalPosition, scoreValue);
        break;
    }
  }

  async public void SpawnThreeEnemies(PackedScene enemyScene, int? option = null, int scoreValue = 0)
  {
    if (option == null) { option = GenericRandom.Int(max: 5); }

    switch (option)
    {
      case 0:
        SpawnEnemyScene(enemyScene, positionList[0].GlobalPosition, scoreValue);
        SpawnEnemyScene(enemyScene, positionList[3].GlobalPosition, scoreValue);
        SpawnEnemyScene(enemyScene, positionList[6].GlobalPosition, scoreValue);
        break;

      case 1:
        SpawnEnemyScene(enemyScene, positionList[1].GlobalPosition, scoreValue);
        SpawnEnemyScene(enemyScene, positionList[3].GlobalPosition, scoreValue);
        SpawnEnemyScene(enemyScene, positionList[5].GlobalPosition, scoreValue);
        break;

      case 2:
        SpawnEnemyScene(enemyScene, positionList[0].GlobalPosition, scoreValue);
        SpawnEnemyScene(enemyScene, positionList[6].GlobalPosition, scoreValue);
        await WaitFor(0.3f);
        SpawnEnemyScene(enemyScene, positionList[3].GlobalPosition, scoreValue);
        break;

      case 3:
        SpawnEnemyScene(enemyScene, positionList[0].GlobalPosition, scoreValue);
        await WaitFor(0.1f);
        SpawnEnemyScene(enemyScene, positionList[3].GlobalPosition, scoreValue);
        await WaitFor(0.1f);
        SpawnEnemyScene(enemyScene, positionList[6].GlobalPosition, scoreValue);
        break;

      case 4:
        SpawnEnemyScene(enemyScene, positionList[6].GlobalPosition, scoreValue);
        await WaitFor(0.1f);
        SpawnEnemyScene(enemyScene, positionList[3].GlobalPosition, scoreValue);
        await WaitFor(0.1f);
        SpawnEnemyScene(enemyScene, positionList[0].GlobalPosition, scoreValue);
        break;

      case 5:
        SpawnEnemyScene(enemyScene, positionList[3].GlobalPosition, scoreValue);
        await WaitFor(2f);
        SpawnEnemyScene(enemyScene, positionList[3].GlobalPosition, scoreValue);
        await WaitFor(2f);
        SpawnEnemyScene(enemyScene, positionList[3].GlobalPosition, scoreValue);
        break;
    }
  }

  async public void SpawnFourEnemies(PackedScene enemyScene, int? option = null, int scoreValue = 0)
  {
    if (option == null) { option = GenericRandom.Int(max: 6); }

    switch (option)
    {
      case 0:
        SpawnEnemyScene(enemyScene, positionList[0].GlobalPosition, scoreValue);
        SpawnEnemyScene(enemyScene, positionList[2].GlobalPosition, scoreValue);
        SpawnEnemyScene(enemyScene, positionList[4].GlobalPosition, scoreValue);
        SpawnEnemyScene(enemyScene, positionList[6].GlobalPosition, scoreValue);
        break;

      case 1:
        SpawnEnemyScene(enemyScene, positionList[0].GlobalPosition, scoreValue);
        SpawnEnemyScene(enemyScene, positionList[2].GlobalPosition, scoreValue);
        await WaitFor(0.3f);
        SpawnEnemyScene(enemyScene, positionList[4].GlobalPosition, scoreValue);
        SpawnEnemyScene(enemyScene, positionList[6].GlobalPosition, scoreValue);
        break;

      case 2:
        SpawnEnemyScene(enemyScene, positionList[1].GlobalPosition, scoreValue);
        SpawnEnemyScene(enemyScene, positionList[3].GlobalPosition, scoreValue);
        await WaitFor(0.2f);
        SpawnEnemyScene(enemyScene, positionList[3].GlobalPosition, scoreValue);
        SpawnEnemyScene(enemyScene, positionList[5].GlobalPosition, scoreValue);
        break;

      case 3:
        SpawnEnemyScene(enemyScene, positionList[0].GlobalPosition, scoreValue);
        await WaitFor(0.1f);
        SpawnEnemyScene(enemyScene, positionList[1].GlobalPosition, scoreValue);
        await WaitFor(0.1f);
        SpawnEnemyScene(enemyScene, positionList[2].GlobalPosition, scoreValue);
        await WaitFor(0.1f);
        SpawnEnemyScene(enemyScene, positionList[3].GlobalPosition, scoreValue);
        break;

      case 4:
        SpawnEnemyScene(enemyScene, positionList[6].GlobalPosition, scoreValue);
        await WaitFor(0.1f);
        SpawnEnemyScene(enemyScene, positionList[5].GlobalPosition, scoreValue);
        await WaitFor(0.1f);
        SpawnEnemyScene(enemyScene, positionList[4].GlobalPosition, scoreValue);
        await WaitFor(0.1f);
        SpawnEnemyScene(enemyScene, positionList[3].GlobalPosition, scoreValue);
        break;

      case 5:
        SpawnEnemyScene(enemyScene, positionList[1].GlobalPosition, scoreValue);
        SpawnEnemyScene(enemyScene, positionList[2].GlobalPosition, scoreValue);
        await WaitFor(0.3f);
        SpawnEnemyScene(enemyScene, positionList[5].GlobalPosition, scoreValue);
        SpawnEnemyScene(enemyScene, positionList[6].GlobalPosition, scoreValue);
        break;

      case 6:
        SpawnEnemyScene(enemyScene, positionList[6].GlobalPosition, scoreValue);
        SpawnEnemyScene(enemyScene, positionList[4].GlobalPosition, scoreValue);
        await WaitFor(0.3f);
        SpawnEnemyScene(enemyScene, positionList[2].GlobalPosition, scoreValue);
        SpawnEnemyScene(enemyScene, positionList[0].GlobalPosition, scoreValue);
        break;
    }
  }

  async public void SpawnFiveEnemies(PackedScene enemyScene, int? option = null, int scoreValue = 0)
  {
    if (option == null) { option = GenericRandom.Int(max: 3); }

    switch (option)
    {
      case 0:
        SpawnEnemyScene(enemyScene, positionList[0].GlobalPosition, scoreValue);
        SpawnEnemyScene(enemyScene, positionList[6].GlobalPosition, scoreValue);
        await WaitFor(0.3f);
        SpawnEnemyScene(enemyScene, positionList[1].GlobalPosition, scoreValue);
        SpawnEnemyScene(enemyScene, positionList[5].GlobalPosition, scoreValue);
        await WaitFor(0.3f);
        SpawnEnemyScene(enemyScene, positionList[3].GlobalPosition, scoreValue);
        break;

      case 1:
        SpawnEnemyScene(enemyScene, positionList[0].GlobalPosition, scoreValue);
        await WaitFor(0.1f);
        SpawnEnemyScene(enemyScene, positionList[1].GlobalPosition, scoreValue);
        await WaitFor(0.1f);
        SpawnEnemyScene(enemyScene, positionList[2].GlobalPosition, scoreValue);
        await WaitFor(0.1f);
        SpawnEnemyScene(enemyScene, positionList[3].GlobalPosition, scoreValue);
        await WaitFor(0.1f);
        SpawnEnemyScene(enemyScene, positionList[4].GlobalPosition, scoreValue);
        break;

      case 2:
        SpawnEnemyScene(enemyScene, positionList[2].GlobalPosition, scoreValue);
        await WaitFor(0.1f);
        SpawnEnemyScene(enemyScene, positionList[3].GlobalPosition, scoreValue);
        await WaitFor(0.1f);
        SpawnEnemyScene(enemyScene, positionList[4].GlobalPosition, scoreValue);
        await WaitFor(0.1f);
        SpawnEnemyScene(enemyScene, positionList[5].GlobalPosition, scoreValue);
        await WaitFor(0.1f);
        SpawnEnemyScene(enemyScene, positionList[6].GlobalPosition, scoreValue);
        break;

      case 3:
        SpawnEnemyScene(enemyScene, positionList[0].GlobalPosition, scoreValue);
        SpawnEnemyScene(enemyScene, positionList[2].GlobalPosition, scoreValue);
        SpawnEnemyScene(enemyScene, positionList[4].GlobalPosition, scoreValue);
        SpawnEnemyScene(enemyScene, positionList[6].GlobalPosition, scoreValue);
        await WaitFor(0.3f);
        SpawnEnemyScene(enemyScene, positionList[3].GlobalPosition, scoreValue);
        break;
    }
  }

  private void SpawnEnemyScene(PackedScene enemyScene, Vector2 position, int scoreValue)
  {
    var enemy = enemyScene.Instance<BaseEnemy>();
    enemy.GlobalPosition = position;
    enemy.scoreValue = scoreValue;
    enemy.Connect("UpdateScore", main, nameof(Main.OnUpdateScore));

    GetParent().AddChild(enemy);
  }

  public void TimeForNextWave(float time) { spawnColdown.Start(time); }

  async private Task WaitFor(float time)
  {
    miniColdown.Start(time);
    await ToSignal(miniColdown, "timeout");
  }

  public void OnTimerOut() { EmitSignal(nameof(Spawner.SpawnTimeout)); }
}
