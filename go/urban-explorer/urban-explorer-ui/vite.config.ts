import { defineConfig } from "vite";
import svgr from "@svgr/rollup";
import preact from "@preact/preset-vite";

// https://vitejs.dev/config/
export default defineConfig({
	plugins: [preact(), svgr()],
	resolve: {
		alias: {
			react: "preact-compat",
			"react-dom": "preact-compat",
		},
	},
});
