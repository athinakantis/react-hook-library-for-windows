import { ReactNode, useEffect, useState } from "react";
import { ThemeContext } from "./themeContext";
import { Theme } from "./themeContext";

export const ThemeProvider = ({ children }: { children: ReactNode }) => {
  const [currentTheme, setCurrentTheme] = useState<Theme>(
    localStorage.theme ||
      (window.matchMedia("(prefers-color-scheme: dark)") ? "dark" : "light"),
  );

  const handleThemeSwitch = () => {
    const newTheme = currentTheme === "light" ? "dark" : "light";
    setCurrentTheme(newTheme);
    localStorage.setItem("theme", newTheme);
  };

  const values = { currentTheme, handleThemeSwitch };

  useEffect(() => {
    currentTheme === "dark"
      ? document.documentElement.classList.add("dark")
      : document.documentElement.classList.remove("dark");
  }, [currentTheme]);

  return (
    <ThemeContext.Provider value={values}>{children}</ThemeContext.Provider>
  );
};
