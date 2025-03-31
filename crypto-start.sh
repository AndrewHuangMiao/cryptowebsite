#!/bin/bash

# Exit on error
set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Default values
DOMAIN="localhost"
HTTP_PORT=3000
HTTPS_PORT=3002
MODE="dev"           # dev, nginx, production
USE_HTTPS=false
INSTALL_NGINX=false

# Print usage info
function usage {
  echo "Usage: $0 [options]"
  echo "Options:"
  echo "  -d, --domain DOMAIN    Domain name (default: localhost)"
  echo "  -p, --port PORT        HTTP port for Node.js (default: 3000)"
  echo "  -s, --ssl-port PORT    HTTPS port for Node.js (default: 3002)"
  echo "  -m, --mode MODE        Mode: dev, nginx, or production (default: dev)"
  echo "                         dev: Run only the Node.js app"
  echo "                         nginx: Run with Nginx as reverse proxy"
  echo "                         production: Run in production mode with all optimizations"
  echo "  -i, --install-nginx    Install Nginx if not already installed"
  echo "  -h, --help             Show this help message"
  echo ""
  echo "Examples:"
  echo "  $0                               # Run in dev mode"
  echo "  $0 --mode nginx                  # Run with Nginx reverse proxy"
  echo "  $0 --mode production --domain example.com  # Production with domain"
  echo "  $0 --port 8080                   # Custom port"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -d|--domain)
      DOMAIN="$2"
      shift 2
      ;;
    -p|--port)
      HTTP_PORT="$2"
      shift 2
      ;;
    -s|--ssl-port)
      HTTPS_PORT="$2"
      shift 2
      ;;
    -m|--mode)
      MODE="$2"
      shift 2
      ;;
    -i|--install-nginx)
      INSTALL_NGINX=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      usage
      exit 1
      ;;
  esac
done

# Validate mode
if [[ "$MODE" != "dev" && "$MODE" != "nginx" && "$MODE" != "production" ]]; then
  echo -e "${RED}Invalid mode: $MODE${NC}"
  usage
  exit 1
fi

echo -e "${GREEN}====================================${NC}"
echo -e "${GREEN}  Starting Crypto Website for $DOMAIN ${NC}"
echo -e "${GREEN}  Mode: $MODE ${NC}"
echo -e "${GREEN}====================================${NC}"
echo ""

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
  OS_TYPE="macos"
elif [ -f /etc/os-release ]; then
  . /etc/os-release
  if [[ "$ID" == "centos" ]] || [[ "$ID_LIKE" == *"centos"* ]] || [[ "$ID_LIKE" == *"rhel"* ]]; then
    OS_TYPE="centos"
  elif [[ "$ID" == "ubuntu" ]] || [[ "$ID" == "debian" ]] || [[ "$ID_LIKE" == *"debian"* ]]; then
    OS_TYPE="debian"
  else
    OS_TYPE="unknown"
  fi
else
  OS_TYPE="unknown"
fi

echo -e "${GREEN}Detected OS: ${OS_TYPE}${NC}"

# Check root privileges if needed
check_root() {
  if [[ "$OS_TYPE" != "macos" ]] && [ "$(id -u)" != "0" ]; then
    if [[ "$MODE" == "nginx" || "$MODE" == "production" || "$INSTALL_NGINX" == true ]]; then
      echo -e "${YELLOW}This mode requires root privileges on Linux.${NC}"
      echo -e "${YELLOW}Please run with sudo or as root.${NC}"
      exit 1
    fi
  fi
}

check_root

# Install Nginx if needed
if [[ "$MODE" == "nginx" || "$MODE" == "production" ]] && [[ "$INSTALL_NGINX" == true ]]; then
  echo -e "${GREEN}Checking if Nginx is installed...${NC}"
  
  if ! command -v nginx &> /dev/null; then
    echo -e "${GREEN}Installing Nginx...${NC}"
    
    case $OS_TYPE in
      macos)
        if ! command -v brew &> /dev/null; then
          echo -e "${YELLOW}Installing Homebrew...${NC}"
          /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        brew install nginx
        ;;
      centos)
        yum update -y
        yum install epel-release -y
        yum install nginx -y
        systemctl enable nginx
        ;;
      debian)
        apt update -y
        apt install nginx -y
        systemctl enable nginx
        ;;
      *)
        echo -e "${RED}Unsupported OS. Please install Nginx manually.${NC}"
        exit 1
        ;;
    esac
    
    echo -e "${GREEN}Nginx installed successfully.${NC}"
  else
    echo -e "${GREEN}Nginx is already installed.${NC}"
  fi
fi

# Start Nginx if needed
if [[ "$MODE" == "nginx" || "$MODE" == "production" ]]; then
  echo -e "${GREEN}Checking if Nginx is running...${NC}"
  
  if ! command -v nginx &> /dev/null; then
    echo -e "${RED}Nginx is not installed. Use --install-nginx flag to install it.${NC}"
    exit 1
  fi
  
  nginx_running=false
  case $OS_TYPE in
    macos)
      if pgrep nginx &> /dev/null; then
        nginx_running=true
      fi
      ;;
    centos|debian)
      if systemctl is-active --quiet nginx; then
        nginx_running=true
      fi
      ;;
    *)
      if pgrep nginx &> /dev/null; then
        nginx_running=true
      fi
      ;;
  esac
  
  if [ "$nginx_running" = false ]; then
    echo -e "${GREEN}Starting Nginx...${NC}"
    
    case $OS_TYPE in
      macos)
        brew services start nginx
        ;;
      centos|debian)
        systemctl start nginx
        ;;
      *)
        nginx
        ;;
    esac
    
    echo -e "${GREEN}Nginx started successfully.${NC}"
  else
    echo -e "${GREEN}Nginx is already running.${NC}"
  fi
  
  # Configure Nginx
  # Create directory for SSL certificates if needed
  mkdir -p "$(pwd)/certs"
  
  # Check if we have SSL certificates
  if [ -f "$(pwd)/certs/localhost+2.pem" ] && [ -f "$(pwd)/certs/localhost+2-key.pem" ]; then
    USE_HTTPS=true
    echo -e "${GREEN}SSL certificates found. HTTPS will be enabled.${NC}"
  else
    echo -e "${YELLOW}SSL certificates not found. Using HTTP only.${NC}"
    echo -e "${YELLOW}To enable HTTPS, generate certificates in the certs directory.${NC}"
    USE_HTTPS=false
  fi
  
  # Create Nginx configuration directory
  case $OS_TYPE in
    macos)
      NGINX_CONF_DIR=$(brew --prefix)/etc/nginx/servers
      mkdir -p "$NGINX_CONF_DIR"
      ;;
    centos|debian)
      NGINX_CONF_DIR=/etc/nginx/conf.d
      ;;
    *)
      NGINX_CONF_DIR=/etc/nginx/conf.d
      ;;
  esac
  
  echo -e "${GREEN}Creating Nginx configuration for $DOMAIN...${NC}"
  
  if [ "$USE_HTTPS" = true ]; then
    # Create configuration for HTTP and HTTPS
    cat > "$NGINX_CONF_DIR/$DOMAIN.conf" << EOF
# HTTP -> HTTPS redirect
server {
    listen 80;
    server_name $DOMAIN www.$DOMAIN;
    
    location / {
        return 301 https://\$host\$request_uri;
    }
}

# HTTPS server
server {
    listen 443 ssl;
    server_name $DOMAIN www.$DOMAIN;
    
    # SSL configuration
    ssl_certificate $(pwd)/certs/localhost+2.pem;
    ssl_certificate_key $(pwd)/certs/localhost+2-key.pem;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers on;
    
    # Proxy headers
    proxy_set_header Host \$host;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto \$scheme;
    
    # Reverse proxy to your application
    location / {
        proxy_pass https://localhost:${HTTPS_PORT};
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF
  else
    # Create configuration for HTTP only
    cat > "$NGINX_CONF_DIR/$DOMAIN.conf" << EOF
server {
    listen 80;
    server_name $DOMAIN www.$DOMAIN;
    
    # Proxy headers
    proxy_set_header Host \$host;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto \$scheme;
    
    # Reverse proxy to your application
    location / {
        proxy_pass http://localhost:${HTTP_PORT};
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF
  fi
  
  echo -e "${GREEN}Nginx configuration created at $NGINX_CONF_DIR/$DOMAIN.conf${NC}"
  
  # Restart Nginx to apply configuration
  case $OS_TYPE in
    macos)
      brew services restart nginx
      ;;
    centos|debian)
      systemctl restart nginx
      ;;
    *)
      nginx -s reload
      ;;
  esac
  
  echo -e "${GREEN}Nginx configuration applied.${NC}"
fi

# Check for Node.js and npm
if ! command -v node &> /dev/null; then
  echo -e "${RED}Node.js is not installed. Please install Node.js first.${NC}"
  exit 1
fi

if ! command -v npm &> /dev/null; then
  echo -e "${RED}npm is not installed. Please install npm first.${NC}"
  exit 1
fi

# Create logs directory
mkdir -p "$(pwd)/logs"

# Stop any existing processes
if [ -f .server.pid ]; then
  PID=$(cat .server.pid)
  if ps -p $PID > /dev/null 2>&1; then
    echo -e "${YELLOW}Stopping existing Node.js process with PID $PID...${NC}"
    kill $PID
    sleep 1
  fi
fi

# Kill any zombie processes
pkill -f "node.*vite" 2>/dev/null || true

# Start the application
echo -e "${GREEN}Starting the application in the background...${NC}"

# Determine startup command based on mode
if [[ "$MODE" == "production" ]]; then
  # Production mode - build and serve
  echo -e "${GREEN}Building application for production...${NC}"
  npm run build
  
  if [ "$USE_HTTPS" = true ]; then
    nohup bash -c "PORT=$HTTP_PORT HTTPS=true HTTPS_PORT=$HTTPS_PORT npm run preview" > logs/server.log 2>&1 &
  else
    nohup bash -c "PORT=$HTTP_PORT npm run preview" > logs/server.log 2>&1 &
  fi
else
  # Dev mode
  if [ "$USE_HTTPS" = true ]; then
    nohup bash -c "PORT=$HTTP_PORT HTTPS=true HTTPS_PORT=$HTTPS_PORT npm run dev" > logs/server.log 2>&1 &
  else
    nohup bash -c "PORT=$HTTP_PORT npm run dev" > logs/server.log 2>&1 &
  fi
fi

# Save PID
echo $! > .server.pid
echo -e "${GREEN}Node.js application started with PID: $!${NC}"

# Show access information
echo -e "${GREEN}====================================${NC}"
echo -e "${GREEN}  Crypto Website is now running!    ${NC}"
echo -e "${GREEN}====================================${NC}"

if [[ "$MODE" == "nginx" || "$MODE" == "production" ]]; then
  if [ "$USE_HTTPS" = true ]; then
    echo -e "${GREEN}Your website is available at:${NC}"
    echo -e "${GREEN}- http://$DOMAIN (redirects to HTTPS)${NC}"
    echo -e "${GREEN}- https://$DOMAIN${NC}"
  else
    echo -e "${GREEN}Your website is available at:${NC}"
    echo -e "${GREEN}- http://$DOMAIN${NC}"
  fi
  
  if [ "$DOMAIN" != "localhost" ]; then
    echo -e "${YELLOW}NOTE: Make sure DNS for $DOMAIN points to this server.${NC}"
    echo -e "${YELLOW}      Also ensure ports 80/443 are open in your firewall.${NC}"
  fi
else
  if [ "$USE_HTTPS" = true ]; then
    echo -e "${GREEN}Your website is available at:${NC}"
    echo -e "${GREEN}- https://localhost:$HTTPS_PORT${NC}"
  else
    echo -e "${GREEN}Your website is available at:${NC}"
    echo -e "${GREEN}- http://localhost:$HTTP_PORT${NC}"
  fi
fi

echo -e "${GREEN}Log file: $(pwd)/logs/server.log${NC}"
echo -e "${YELLOW}To stop the application, run: ./crypto-stop.sh${NC}"
echo -e "${GREEN}====================================${NC}" 