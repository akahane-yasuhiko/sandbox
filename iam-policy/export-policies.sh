#!/bin/sh

# export policy Statement to {PolicyName}.json

# # # # # # # # # # # # # # # # # # # # # # # # # #
# Before running
# This script uses "jq", so please do the following.
# - Get "jq" from "https://stedolan.github.io/jq/"
# - Modify the file name to "jq"
# - Pass the path
# # # # # # # # # # # # # # # # # # # # # # # # # #

# list policies
policies=`aws iam list-policies --scope Local | jq '.Policies[] | (.PolicyName|tostring) + " " + (.Arn|tostring) + " " + .DefaultVersionId' -r`
echo -n > command-list.txt

# export listed policies
while read name arn ver
do
	ver=`echo $ver|sed 's/\r\n/\n/'` #Fixed line feed code.
	echo "aws iam get-policy-version --policy-arn $arn --version-id $ver">>command-list.txt
	aws iam get-policy-version --policy-arn $arn --version-id $ver | jq '.PolicyVersion.Document' >${name}.json
done <<<$policies
