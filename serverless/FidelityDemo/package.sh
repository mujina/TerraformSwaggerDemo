#!/bin/bash

TAG=${1:-latest}

# Create and initialize a Python Virtual Environment
echo "Creating virtual env - .env"
python3 -m venv .env

echo "sourcing virtual env - .env"
source .env/bin/activate

# Create a directory to put things in
echo "Creating 'setup' directory"
mkdir setup

# Move the relevant files into setup directory
echo "Moving function file(s) to setup dir"
cp index.py setup/
cd ./setup

# Install requirements
echo "pip installing requirements from requirements file in target directory"
pip install -r ../requirements.txt -t .

# Prepares the deployment package
echo "Zipping package"
zip -r ../package-${TAG}.zip ./*

# Remove the setup directory used1
echo "Removing setup directory and virtual environment"
cd ..
rm -r ./setup
deactivate
rm -r ./.env
# changing dirs back to dir from before
echo "Opening folder containing function package - 'package.zip'"
open .

aws s3 cp package-${TAG}.zip s3://pugme-deploy/fidelity-demo/package-${TAG}.zip