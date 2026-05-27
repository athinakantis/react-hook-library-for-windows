import { createContext } from "react";

export const ThemeContext = createContext({
  currentTheme:
    localStorage.theme ||
    (!("theme" in localStorage) &&
    window.matchMedia("(prefers-color-scheme: dark)").matches
      ? "dark"
      : "light"),
  handleThemeSwitch: () => {},
});
