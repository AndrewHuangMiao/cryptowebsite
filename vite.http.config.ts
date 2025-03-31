import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// Configuration specifically for HTTP server
export default defineConfig({
  plugins: [react()],
  server: {
    host: '0.0.0.0',
    port: 80,
  },
}) 