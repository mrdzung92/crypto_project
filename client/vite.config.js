import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
const BASE_URL = 'http://crypto.local'
// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    vue(),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  },
  define: {
    'process.env': {
      VITE_API_BASE_URL:BASE_URL,
    },
  },
  server: {
    proxy: {
      '/captcha':BASE_URL,
      '/storage':BASE_URL,
    },
  },
})
