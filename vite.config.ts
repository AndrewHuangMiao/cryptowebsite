import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import fs from 'fs'
import path from 'path'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    host: '0.0.0.0',
    port: 3000,
    https: {
      cert: fs.readFileSync(path.resolve(__dirname, 'certs/localhost+2.pem')),
      key: fs.readFileSync(path.resolve(__dirname, 'certs/localhost+2-key.pem')),
    },
    proxy: {
      '/api': {
        target: 'http://localhost:80',
        changeOrigin: true,
      },
    },
  },
})
