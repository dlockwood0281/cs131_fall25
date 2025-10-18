#!/bin/bash
# update-all.sh
git submodule foreach git pull origin main
git add .
git commit -m "Update all student submodules $(date +%Y-%m-%d)"
