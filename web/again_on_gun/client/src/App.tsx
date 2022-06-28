import Gun from "gun";
import { useEffect, useState } from "react";

const gun = Gun({ peers: ["http:localhost:8000/gun"] });

export function App() {
  const [txt, setTxt] = useState<string>();

  useEffect(() => {
    gun.get("text").once((node) => {
      if (!node) {
        gun.get("text").put({ text: "Write the text here" });
        return;
      }

      setTxt(node.text);
    });

    gun.get("text").on((node) => {
      setTxt(node.text);
    });
  }, []);

  const updateText = (event: React.ChangeEvent<HTMLTextAreaElement>) => {
    gun.get("text").put({ text: event.target.value });
    setTxt(event.target.value);
  };

  return (
    <div className="App">
      <h1>Relay WebRTC Database</h1>
      <textarea value={txt} onChange={updateText} />
    </div>
  );
}

export default App;
