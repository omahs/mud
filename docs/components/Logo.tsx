import React, { useState, useEffect } from "react";

export default function Logo({ theme }) {
  const [src, setSrc] = useState("/logo512-white.png"); // default to the dark theme logo

  useEffect(() => {
    setSrc(theme === "light" ? "/logo512-black.png" : "/logo512-white.png");
  }, [theme]);

  return <img src={src} alt="MUD logo" />;
}
