using Godot;
using System;

namespace Utils
{
  public static class GamePersistance
  {
    private static string saveFile = "user://buffer";

    public static void SaveData(GameData data)
    {
      Save(XMLConverter.Stringify(data), saveFile);
    }

    public static GameData LoadData()
    {
      string data = Load(saveFile);
      if (data != null)
      {
        var thing = XMLConverter.Parse<GameData>(data);
        return thing;
      }

      return new GameData();
    }

    private static void Save(string data, string filePath)
    {
      var file = new File();
      file.Open(filePath, File.ModeFlags.Write);
      file.StoreString(data);
      file.Close();
    }

    private static string Load(string filePath)
    {
      var file = new File();

      if (file.FileExists(filePath))
      {
        file.Open(filePath, File.ModeFlags.Read);
        string data = file.GetAsText();
        file.Close();

        return data;
      }

      return null;
    }
  }
}