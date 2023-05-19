import { defineConfig } from "tsup";

export default defineConfig({
  entry: ["mud.config.ts", "ts/library/index.ts", "ts/register/index.ts", "ts/library/config/index.ts"],
  target: "esnext",
  format: ["esm"],
  dts: false,
  sourcemap: true,
  clean: true,
  minify: true,
});
