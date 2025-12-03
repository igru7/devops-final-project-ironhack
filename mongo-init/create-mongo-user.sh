#!/bin/bash

# Variables
MONGO_CONTAINER="mongo"
ROOT_USER="root"
ROOT_PASSWORD="example"
NEW_USER="mongo"
NEW_PASSWORD="mongo"
DB_NAME="mydb"

# Wait for MongoDB to be ready
echo "Waiting for MongoDB to start..."
until docker exec $MONGO_CONTAINER mongo -u $ROOT_USER -p $ROOT_PASSWORD --authenticationDatabase admin --eval "db.adminCommand('ping')" &>/dev/null; do
  sleep 2
done
echo "MongoDB is ready!"

# Create the new user
docker exec -i $MONGO_CONTAINER mongo -u $ROOT_USER -p $ROOT_PASSWORD --authenticationDatabase admin <<EOF
use $DB_NAME
db.createUser({
  user: "$NEW_USER",
  pwd: "$NEW_PASSWORD",
  roles: [{ role: "readWrite", db: "$DB_NAME" }]
})
EOF

echo "User '$NEW_USER' created on database '$DB_NAME'"
