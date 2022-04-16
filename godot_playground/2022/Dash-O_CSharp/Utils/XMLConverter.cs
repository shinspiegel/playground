using Godot;
using System;
using System.IO;
using System.Xml.Serialization;
using System.Xml;

namespace Utils
{
  public class XMLConverter
  {
    public static string Stringify(object o)
    {
      StringWriter sw = new StringWriter();
      XmlTextWriter tw = null;

      XmlSerializer serializer = new XmlSerializer(o.GetType());
      tw = new XmlTextWriter(sw);
      serializer.Serialize(tw, o);

      sw.Close();

      if (tw != null) { tw.Close(); }

      return sw.ToString();
    }

    public static T Parse<T>(string xml)
    {
      StringReader strReader = null;
      XmlSerializer serializer = null;
      XmlTextReader xmlReader = null;
      T obj;

      strReader = new StringReader(xml);
      serializer = new XmlSerializer(typeof(T));
      xmlReader = new XmlTextReader(strReader);
      obj = (T)serializer.Deserialize(xmlReader);

      if (xmlReader != null) { xmlReader.Close(); }
      if (strReader != null) { strReader.Close(); }

      return obj;
    }
  }
}