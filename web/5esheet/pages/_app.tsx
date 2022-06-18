import { Provider } from "react-redux";
import type { AppProps } from "next/app";
import { store } from "../stores/store";
import "../styles/globals.scss";

function MyApp({ Component, pageProps }: AppProps) {
  return (
    <Provider store={store}>
      <Component {...pageProps} />
    </Provider>
  );
}

export default MyApp;
