#!/bin/bash

export TF_VAR_environment='Dev'
export TF_VAR_audience='Dev'
export TF_VAR_s3_bucket='pugme-deploy'
export TF_VAR_created_by=$USER

# This is going to have to merge the swagger

cd ../../../Swagger/SwaggerMerge
python3 index.py
cd -

exec terraform "$@"
