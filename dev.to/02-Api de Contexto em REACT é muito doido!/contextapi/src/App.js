import React, { useContext } from "react";
import { ContextAPI } from "./index";

/* App.js */
const App = () => {
  // Tua aplicação faz o que precisa e esquece do menu, porque ele já existe no index.js!

  return (
    <div>
      <Menu />
      {/*resto da sua aplicação*/}
    </div>
  );
};

/* Menu.js */
const Menu = (props) => {
  const contexto = useContext(ContextAPI);

  return (
    <ul>
      {contexto.map((menu) => (
        <MenuItem icon={menu.icon}>{menu.nome}</MenuItem>
      ))}
    </ul>
  );
};

/* MenuItem.js */
const MenuItem = (props) => (
  <li>
    <i>{props.icon} </i>
    <p>{props.children}</p>
  </li>
);

export default App;
