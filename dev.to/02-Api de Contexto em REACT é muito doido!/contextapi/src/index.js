import React, { createContext, useContext, useReducer } from "react";
import reactDom from "react-dom";
import "./index.css";

/* context.js */
const InitialState = {
  menu: [
    { nome: "Perfil", icon: "😀" },
    { nome: "Configurações", icon: "💻" },
    { nome: "Sair", icon: "🔴" },
  ],
};

const AppContext = createContext(InitialState);

const CustomContext = ({ children }) => {
  const [state, dispatch] = useReducer(reducer, InitialState);

  return (
    <AppContext.Provider value={{ state, dispatch }}>
      {children}
    </AppContext.Provider>
  );
};

/* reducer.js */
const reducer = (state, { type, payload }) => {
  switch (type) {
    case "MENU":
      return {
        ...state,
        menu: [...state.menu, payload],
      };

    default:
      return state;
  }
};

/* useActions.js */
const useActions = () => {
  const { state, dispatch } = useContext(AppContext);

  const anotherMenu = (nome) => {
    dispatch({ type: "MENU", payload: { nome, icon: "🤯" } });
    return;
  };

  return {
    state,
    anotherMenu,
  };
};

/* App.js */
const App = () => {
  const { anotherMenu } = useActions();

  // Se tua cabeça não explodir eu não sei o que vai fazer!

  return (
    <div>
      <Menu />
      <button onClick={() => anotherMenu("Cooontexto")}>Novo Menu</button>
      {/*resto da sua aplicação*/}
    </div>
  );
};

/* Menu.js */
const Menu = (props) => {
  const { state } = useActions();

  return (
    <ul>
      {state.menu.map((menu) => (
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

reactDom.render(
  <CustomContext>
    <App />
  </CustomContext>,
  document.getElementById("root")
);
