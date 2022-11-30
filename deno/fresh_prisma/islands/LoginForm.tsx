import { JSX } from "preact";
import { sanitizeFormElement } from "../utils/sanitizeFormElement.ts";

export function getValuesFromFormElement(formElement: HTMLFormElement) {}

export default function LoginForm() {
  const submitHandler = async (e: JSX.TargetedEvent<HTMLFormElement, Event>) => {
    try {
      e.preventDefault();
      const formValues = sanitizeFormElement(e.currentTarget, [{ name: "username" }, { name: "password" }]);

      const resp = await fetch("/api/auth/login", {
        body: JSON.stringify(formValues),
        method: "POST",
        headers: { "content-type": "application/json" },
      });

      if (resp.status >= 400) {
        throw new Error(await resp.text());
      }

      // localStorage.setItem("cred", JSON.stringify(await resp.json()));
    } catch (err) {
      console.info(err);
    }
  };

  return (
    <form onSubmit={submitHandler}>
      <label>
        Username
        <input name="username" type="text" />
      </label>
      <label>
        Password
        <input name="password" type="password" />
      </label>

      <button type="submit">Login</button>
    </form>
  );
}
