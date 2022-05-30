import type { Component } from 'solid-js';
import styles from './App.module.scss';

const App: Component = () => (
  <div class={styles.App}>
    <header class={styles.header}>
      <p>
        Edit <code>src/App.tsx</code> and save to reload!!!
      </p>

      <a class={styles.link} href='https://github.com/solidjs/solid' target='_blank' rel='noopener noreferrer'>
        Learn Solid
      </a>
    </header>
  </div>
);

export default App;
