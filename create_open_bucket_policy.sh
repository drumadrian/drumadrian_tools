


###########################################################
#  Name: create_open_bucket_policy
#  Usage: bash create_open_bucket_policy.sh mybucketname
#   Output file:   bucket_policy.json
#
#  To get help:   bash create_open_bucket_policy.sh -h  
#
###########################################################





command_usage_help="


Usage: Typical usage of this script is as follows: 

  bash create_open_bucket_policy.sh my-new-bucket-name

"





help_flag="-h"

if [ "$1" == "$help_flag" ] 
then
# echo
# echo
  echo  " $command_usage_help "
# echo
# echo
  exit 0
fi


bucket_name=$1

bucketpolicytemplate='
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"AddPerm",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::examplebucket/*"]
    }
  ]
}
'

echo
echo
echo $bucketpolicytemplate

bucketpolicytemplate_part1='
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"AddPerm",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::'


bucketpolicytemplate_part2='/*"]
    }
  ]
}
'

final_bucket_policy="$bucketpolicytemplate_part1$bucket_name$bucketpolicytemplate_part2"

echo
echo
echo


echo 'bucket_name='
echo "$bucket_name"

echo
echo
echo

echo 'final_bucket_policy='
echo $final_bucket_policy



####################################################################################
#######  Finally, output the bucket policy to the file:    bucket_policy.json
####################################################################################

echo $final_bucket_policy > bucket_policy.json


echo
echo
echo
echo "  Your new file in the current directory is named:  bucket_policy.json  "
echo
echo
