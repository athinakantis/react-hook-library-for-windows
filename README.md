# React Hook Library For Windows

A lightweight library of react hooks for windows. Relies on no packages - it simply uses a few custom scripts.  
After setup you will be able to install the custom hooks within any project.

## Table of Contents

## Available Hooks

### debounce

Returns any value after a custom amount of time

| param | type   | description                                         |
| ----- | ------ | --------------------------------------------------- |
| value | any    | whatever value you'd like to return after the delay |
| delay | number | time in ms                                          |

### screensize

**Returns**

The screensize hook follows tailwind conventions

```tsx
export const MD_BREAKPOINT = 768;
export const LG_BREAKPOINT = 1024;
```

```tsx
isMobile: boolean;
isTablet: boolean;
isDesktop: boolean;
width: number;
```

### theme

Uses a react context with a light and dark theme.  
The theme is set up in three parts: a provider, a context and a hook.

The default theme is whatever is the preferred theme of the users browser

```ts
window.matchMedia("(prefers-color-scheme: dark)");
```

**Returns**

```tsx
currentTheme: Theme; // "light" or "dark"
handleThemeSwitch: () => void; // a function that toggles the theme
```

**Note**  
By default the ThemeProvider will be added to `main.tsx` and wrap around the `<App/>` component.

## Setup

In order for these to be available at any path, you must add the script to your environment variables.

1. Open system priorities
1. Copy the absolute path where you have cloned the library
1. Click "environment variables"
1. Under "user variables for -username-" choose "Path" and then click "Edit..."
1. Click "New" and paste the absolute path
1. Save your changes

## Running the script

Run the script by entering "rhl" into the command line
```pwsh
rhl
```

There are a few flags available. These are optional and if not provided you will be prompted for the values.

| flags       | available values                    | description                   | required |
| ----------- | ----------------------------------- | ----------------------------- | -------- |
| -l or -lang | `js` or `ts`                        | The language of your choosing | No       |
| -h or -hook | `debounce`, `screensize` or `theme` | The hook of your choosing     | No       |

