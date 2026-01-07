#!/bin/bash

# Apply CORS configuration to the development bucket
gsutil cors set cors.json gs://dev-fof.firebasestorage.app

echo "CORS configuration applied to gs://dev-fof.firebasestorage.app"
