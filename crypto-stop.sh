#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Default options
STOP_NGINX=false
FORCE=false
DOMAIN="localhost"

# Print usage info
function usage {
  echo "Usage: $0 [options]"
  echo "Options:"
  echo "  -n, --stop-nginx      Stop Nginx server as well"
  echo "  -f, --force           Force kill processes if normal termination fails"
  echo "  -d, --domain DOMAIN   Domain name for Nginx configuration cleanup (default: localhost)"
  echo "  -h, --help            Show this help message"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -n|--stop-nginx)
      STOP_NGINX=true
      shift
      ;;
    -f|--force)
      FORCE=true
      shift
      ;;
    -d|--domain)
      DOMAIN="$2"
      shift 2
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

echo -e "${GREEN}====================================${NC}"
echo -e "${GREEN}  Stopping Crypto Website           ${NC}"
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

# Check root privileges if stopping Nginx
if [[ "$STOP_NGINX" == true && "$OS_TYPE" != "macos" ]]; then
  if [ "$(id -u)" != "0" ]; then
    echo -e "${YELLOW}Stopping Nginx requires root privileges on Linux.${NC}"
    echo -e "${YELLOW}Please run with sudo or as root.${NC}"
    exit 1
  fi
fi

# Stop Node.js application
echo -e "${GREEN}Stopping Node.js application...${NC}"

# Check if PID file exists
if [ -f .server.pid ]; then
  PID=$(cat .server.pid)
  
  # Check if the process is running
  if ps -p $PID > /dev/null 2>&1; then
    echo -e "${GREEN}Stopping process with PID: $PID${NC}"
    
    # Try graceful shutdown first
    kill $PID
    
    # Wait for process to terminate
    TIMEOUT=5
    while ps -p $PID > /dev/null 2>&1 && [ $TIMEOUT -gt 0 ]; do
      echo -e "${YELLOW}Waiting for process to terminate ($TIMEOUT seconds left)...${NC}"
      sleep 1
      TIMEOUT=$((TIMEOUT-1))
    done
    
    # Force kill if process is still running and force flag is set
    if ps -p $PID > /dev/null 2>&1; then
      if [ "$FORCE" = true ]; then
        echo -e "${YELLOW}Process still running. Forcing termination...${NC}"
        kill -9 $PID
      else
        echo -e "${RED}Process didn't terminate within timeout period.${NC}"
        echo -e "${RED}Use --force flag to forcefully terminate the process.${NC}"
        exit 1
      fi
    fi
    
    echo -e "${GREEN}Node.js application stopped successfully.${NC}"
  else
    echo -e "${YELLOW}Process with PID $PID is not running.${NC}"
  fi
  
  # Remove PID file
  rm .server.pid
  echo -e "${GREEN}Removed PID file.${NC}"
else
  echo -e "${YELLOW}No PID file found. Checking for running processes...${NC}"
  
  # Try to find and kill any Node.js processes related to the application
  NODE_PIDS=$(pgrep -f "node.*vite" 2>/dev/null || echo "")
  
  if [ -n "$NODE_PIDS" ]; then
    echo -e "${GREEN}Found Node.js processes: $NODE_PIDS${NC}"
    
    for PID in $NODE_PIDS; do
      if [ "$FORCE" = true ]; then
        kill -9 $PID 2>/dev/null
      else
        kill $PID 2>/dev/null
      fi
    done
    
    echo -e "${GREEN}Attempted to stop all Node.js processes.${NC}"
  else
    echo -e "${YELLOW}No running Node.js processes found.${NC}"
  fi
fi

# Stop Nginx if requested
if [ "$STOP_NGINX" = true ]; then
  echo -e "${GREEN}Stopping Nginx...${NC}"
  
  # Check if Nginx is installed
  if ! command -v nginx &> /dev/null; then
    echo -e "${YELLOW}Nginx is not installed. Skipping.${NC}"
  else
    # Stop Nginx based on OS
    case $OS_TYPE in
      macos)
        brew services stop nginx
        ;;
      centos|debian)
        systemctl stop nginx
        ;;
      *)
        nginx -s stop
        ;;
    esac
    
    echo -e "${GREEN}Nginx stopped successfully.${NC}"
    
    # Optionally clean up Nginx configuration
    if [ "$DOMAIN" != "localhost" ]; then
      # Determine Nginx configuration directory
      case $OS_TYPE in
        macos)
          NGINX_CONF_DIR=$(brew --prefix)/etc/nginx/servers
          ;;
        centos|debian)
          NGINX_CONF_DIR=/etc/nginx/conf.d
          ;;
        *)
          NGINX_CONF_DIR=/etc/nginx/conf.d
          ;;
      esac
      
      # Check if domain configuration exists
      if [ -f "$NGINX_CONF_DIR/$DOMAIN.conf" ]; then
        read -p "Do you want to remove the Nginx configuration for $DOMAIN? (y/n): " REMOVE_CONF
        if [[ "$REMOVE_CONF" =~ ^[Yy]$ ]]; then
          rm "$NGINX_CONF_DIR/$DOMAIN.conf"
          echo -e "${GREEN}Removed Nginx configuration for $DOMAIN.${NC}"
        fi
      fi
    fi
  fi
fi

echo -e "${GREEN}====================================${NC}"
echo -e "${GREEN}  Crypto Website stopped successfully${NC}"
echo -e "${GREEN}====================================${NC}" 