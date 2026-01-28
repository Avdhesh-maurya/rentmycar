#!/bin/bash
set -e

echo "Installing server dependencies..."
cd server
npm install
npm ci --only=production

echo "Build completed successfully!"
