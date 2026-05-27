import { createContext } from "react";

export type Theme = "light" | "dark";

interface ThemeContextProps {
  currentTheme: Theme;
  handleThemeSwitch: () => void;
}

export const ThemeContext = createContext<ThemeContextProps>({
  currentTheme:
    localStorage.theme ||
    (!("theme" in localStorage) &&
    window.matchMedia("(prefers-color-scheme: dark)").matches
      ? "dark"
      : "light"),
  handleThemeSwitch: () => {},
});
