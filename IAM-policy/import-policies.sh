#!/bin/sh

#aws iam create-policy --policy-name my-policy --policy-document file://DenyIp.json
for filename in *.json; do
    echo $filename
    echo ${filename%.*}
    echo "aws iam create-policy --policy-name ${filename%.*} --policy-document file://$filename"
    aws iam create-policy --policy-name ${filename%.*} --policy-document file://$filename
done

