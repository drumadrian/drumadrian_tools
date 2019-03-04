
[![Build Status](https://travis-ci.org/drumadrian/drumadrian_tools.svg?branch=master)](https://travis-ci.org/drumadrian/Polly-Whitepapers.svg?branch=master) [![Codacy Badge](https://api.codacy.com/project/badge/Grade/07a94491e8474578b8808afce12e0e5c)](https://www.codacy.com/app/drumadrian/drumadrian_tools?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=drumadrian/drumadrian_tools&amp;utm_campaign=Badge_Grade)

# AWS Parent Account Management
This project is intended to document the tools and cloudformation stacks used to mangage Parent AWS Accounts (when using AWS Organizations) and also child accounts.  



## Deployment Pipeline

![alt text](https://raw.githubusercontent.com/drumadrian/drumadrian_tools/master/parent_aws_account_management_tools/AWS_Parent_Account_Management_Deployment_Flow.png)


## Getting Started (to be updated)

1. [Fork this repo](fork).
2. Launch the Deployment Pipeline CloudFormation stack:
    1. [![Launch Stack](https://cdn.rawgit.com/buildkite/cloudformation-launch-stack-button-svg/master/launch-stack.svg)](https://console.aws.amazon.com/cloudformation/home#/stacks/new?stackName=aws-parent-account-management&templateURL=https://github.com/drumadrian/drumadrian_tools/tree/master/parent_aws_account_management_tools/deployment_pipeline/deployment_pipeline.yaml)
    2. Enter all parameters details.
    4. Enter the name of an S3 bucket for storing pipeline artifacts in the `ArtifactBucket` field. ([Create a bucket](http://docs.aws.amazon.com/AmazonS3/latest/gsg/CreatingABucket.html) first if necessary.)
3. Verify the newly-created stack and pipeline.
    1. Check the [CloudFormation Console](https://console.aws.amazon.com/cloudformation) to ensure your stack reaches the `CREATE_COMPLETE` state successfully.
4. TBD
    1. TBD
    2. TBD
5. TBD
    1. TBD
6. TBD
  a. TBD
  b. TBD
  c. TBD

That's it!





## Create the Deployment Pipeline using Adrian DevOps CLI: 


Setup

```
chmod +x adriandevops
export PATH=$PATH:./
adriandevops --help

```

Usage

```

    USAGE: adriandevops [OPTIONS] 

    OPTIONS

	-h     Dispplay this help dialog
	-p     Displays the awsstudygurus tool variables 
	         (varies based on branch)

	-d     Runs with defaults (not yet implemented)
	-r     Forces a reset (not yet implemented)

	-dp    Creates the Cloudformation stack for the Deployment pipeline
	         The Deployment pipeline deploys the app code and 
	         must be created first
	-da    Pushes the application code to the origin for the Deployment pipeline
	         The Deployment pipeline must be created first.  Automation 
	         for the AWS pipeline must be setup using the BitBucket repo plugin
	         https://marketplace.atlassian.com/apps/1211351/repository-mirror-plugin-for-bitbucket?hosting=server&tab=overview
	         https://github.com/ef-labs/stash-hook-mirror/wiki

	-delp  Deletes the Cloudformation stack and related resources for the Deployment pipeline
	-dela  Deletes the Cloudformation stacks and related resources for the Application


	--help 		    Same as -h
	--printvariables    Same as -p
	--deploy_pipeline   Same as -dp
	--deploy_app 	    Same as -da
	--destroy_pipeline  Same as -delp
	--destroy_app	    Same as -dela
	--default 	    not yet implemented
	--reset  	    not yet implemented


```


<br/>
<br/>
<br/>
<br/>







#### Relevant Repos:

- https://github.com/sunilake/AWSSolutionsReference




