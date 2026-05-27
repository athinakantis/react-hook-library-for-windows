import { useEffect, useState } from "react";

export const MD_BREAKPOINT = 768;
export const LG_BREAKPOINT = 1024;

/**
 * Returns booleans for mobile / tablet / desktop + the current width.
 *
 * - mobile: width < 768
 * - tablet: 768 <= width < 1024
 * - desktop: width >= 1024
 */
export function useIsMobile() {
  const [state, setState] = useState({
    isMobile: false,
    isTablet: false,
    isDesktop: false,
    width: 0,
  });

  useEffect(() => {
    if (typeof window === "undefined") return;

    const update = () => {
      const w = window.innerWidth;
      setState({
        isMobile: w < MD_BREAKPOINT,
        isTablet: w >= MD_BREAKPOINT && w < LG_BREAKPOINT,
        isDesktop: w >= LG_BREAKPOINT,
        width: w,
      });
    };

    // set initial state
    update();

    window.addEventListener("resize", update);
    return () => window.removeEventListener("resize", update);
  }, []);

  return state;
}
