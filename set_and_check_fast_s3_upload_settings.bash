


# copy and paste the lines below into your PowerShell or Bash prompt for faster S3 sync OR multi-part uploads

aws configure set default.s3.max_concurrent_requests 100
aws configure set default.s3.max_queue_size 20000
aws configure set default.s3.multipart_threshold 64MB
aws configure set default.s3.multipart_chunksize 64MB
aws configure set default.s3.max_bandwidth 50MB/s
aws configure set default.s3.use_accelerate_endpoint true
aws configure set default.s3.addressing_style path



# copy and paste the lines below into to check your aws shell settings

aws configure get default.s3.max_concurrent_requests 
aws configure get default.s3.max_queue_size 
aws configure get default.s3.multipart_threshold 
aws configure get default.s3.multipart_chunksize 
aws configure get default.s3.max_bandwidth 
aws configure get default.s3.use_accelerate_endpoint
aws configure get default.s3.addressing_style

