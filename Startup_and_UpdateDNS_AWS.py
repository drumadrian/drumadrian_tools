
##################################################################################################
# Purpose:      This function will be triggered when an EC2 instance
#               is started that needs to have an A-Record updated with
#               the newly assigned Public AWS Elastic IP address.
#
# Author:       Adrian Drummond
#
# Date:         March 1, 2017  (initial creation)
#               ?              (updated)
#
# Triggered by: The AWS EC2 instance should trigger an AWS CloudWatch event
#
# Summary: 		The triggered CloudWatch event should post to an AWS SNS topic
#               The SNS topic should alert the admin that the Instance has been started
#        		and the Lambda function is being triggered with the CloudWatch information
#        		The Lambda function should find the AWS EC2 instance using the instanceID
#        		and get the Public IP address.  The EC2 Instance should also be tagged
#        		with the desired public DNS Name.  Ex: securefiles.diegotax.com
#        		The function should updated the A Record in AWS Route53 to have the new AWS
#        		assigned Public IP address.
##################################################################################################


import boto3
import pprint


# ToDo:  
#       1) add SNS topic notifications
#       2) check current DNS entry for host
#       3) lookup SNS Target ARN based on hostname in context data        
#       4) need to Finish coding:   update_instance_hostname()
#       5) update test_event for Offline Testing



####### Global debugging flag #######
DEBUG = True



#Find the instance
def get_instance(event):
    # IDofInstance = event['instanceID']
    # print 'IDofInstance = {}'.format(IDofInstance)
    # return IDofInstance

    if DEBUG:
        print("event=")
        print(event)
        print("")
        print("")

    the_instance_id_from_SNS_event = event["detail"]["instance-id"]

    if DEBUG:
        print "the_instance_id_from_SNS_event = "
        print (the_instance_id_from_SNS_event)
        print ""
        print ""

    return the_instance_id_from_SNS_event



#Get the Public IP
def get_public_IP_and_instance_hostname(targetInstance_ID):
    ##boto3 = boto3.client('EC2')
    #publicIP = boto3.get_public_IP(targetInstance_ID)
    
    # publicIP = '123.235.122.112'
    # print 'publicIP = {}'.format(publicIP)
    # return publicIP


    if DEBUG:
        print "------------------------"
        print ""
        print ""


    client = boto3.client('ec2')
    ipaddress = "12.23.34.45"   #Default for testing and in case the function somehow ran when the instance was not running
    tagKey_forDNS_hostname = "dnsname"
    tagKey_for_IP_address = "PublicIpAddress"
    # tagValue = ""
    # zone = ""
    # info = ""
    hostname_value = ""
    list_of_tags = ""


    instance_dict = client.describe_instances().get('Reservations')
    for reservation in instance_dict:
        for instance in reservation['Instances']: # This is rather not obvious
           # print "The Instance Id is:"
           # print instance["InstanceId"]

            if instance["InstanceId"] == targetInstance_ID:
                if DEBUG:
                    print "Found matching Instance ID"
                    # print instance
                    print ""
                    print "Instance="
                    print pprint.pprint(instance)
                    print "Instance State = " + instance[unicode('State')][unicode('Name')]

                # if instance[unicode('State')][unicode('Name')] == 'running' and instance[unicode('PublicIpAddress')] != None:           
                if instance[unicode('State')][unicode('Name')] == 'running' and instance[unicode(tagKey_for_IP_address)] != None:
                    ipaddress = instance[tagKey_for_IP_address]
                    if DEBUG:
                        print "Extracted Public addres=" + ipaddress

                ########## CODE FOR GETTING THE (desired) DNS HOSTNAME FROM INSTANCE ###############
                list_of_tags = instance["Tags"] # 'Tags' is a list
                
                for tag in list_of_tags:
                    if tag["Key"] == tagKey_forDNS_hostname:
                        hostname_value = tag["Value"]
                        if DEBUG:
                            print "Extracted Desired DNS hostname=" + hostname_value


    return ipaddress, hostname_value




#Get the DNS/hostname to be updated
# def get_instance_hostname():
#     ##boto3 = boto3.client('EC2')
#     #publicIP = boto3.get_public_IP(targetInstance_ID)

#     publicIP = '123.235.122.112'
#         print 'publicIP = {}'.format(publicIP)
#         return publicIP



def get_hostedzoneid_from_hostname(hostname):
    # hostname = "owncloud.adrianws.com"

    hosted_zone_id = ""
    string_list = hostname.split(".")
    list_length = len(string_list)
    top_level_domain = string_list[list_length - 1]
    top_level_domain_name = string_list[list_length - 2]

    hosted_zone_name = top_level_domain_name + "." + top_level_domain + "."

    if DEBUG:
        print "hosted_zone_name="
        print hosted_zone_name

    client = boto3.client('route53')
    response = client.list_hosted_zones()

    for hostedzone in response["HostedZones"]:
      if DEBUG:
        print "hostedzone="
        pprint.pprint(hostedzone)
        print "" 
      if hostedzone["Name"] == hosted_zone_name:
        hosted_zone_id = hostedzone["Id"]
        if DEBUG:
          print "Found matching hosted zone in Route53!"
          print "hosted_zone_id="
          print hosted_zone_id
        break

    return hosted_zone_id




#Update the hostname if it is not already set to the desired hostname
def update_instance_hostname(public_IP, the_desired_hostname):
    # hostname_already_setup = False
    target_HostedZoneId = get_hostedzoneid_from_hostname(the_desired_hostname)
    # my_region = 'us-west-2'
    # public_IP = "22.23.34.45"                   
    DNS_name =  the_desired_hostname + "."

    if DEBUG:
        print "------------------------"
        print "the_desired_hostname="
        print the_desired_hostname
        print ""
        print "target_HostedZoneId="
        print target_HostedZoneId
        print ""
        print ""
        print "DNS_name="
        print DNS_name


    client = boto3.client('route53')
    response = client.change_resource_record_sets(
        HostedZoneId=target_HostedZoneId,
        ChangeBatch={
            'Comment': 'Updated by updateDNSaRecord() Lambda function',
            'Changes': [
                {
                    'Action': 'UPSERT',
                    'ResourceRecordSet': {
                        # 'Name': 'string',
                        'Name': DNS_name,
                        'Type': 'A',
                        # 'SetIdentifier': 'string',
                        # 'Weight': 123,
                        # 'Region': 'us-east-1'|'us-east-2'|'us-west-1'|'us-west-2'|'ca-central-1'|'eu-west-1'|'eu-west-2'|'eu-central-1'|'ap-southeast-1'|'ap-southeast-2'|'ap-northeast-1'|'ap-northeast-2'|'sa-east-1'|'cn-north-1'|'ap-south-1',
                        # 'Region': my_region,
                        # 'GeoLocation': {
                        #     'ContinentCode': 'string',
                        #     'CountryCode': 'string',
                        #     'SubdivisionCode': 'string'
                        # },
                        # 'Failover': 'PRIMARY'|'SECONDARY',
                        'TTL': 60,
                        'ResourceRecords': [
                            {
                                'Value': public_IP
                            }
                        ]
                        # 'AliasTarget': {
                        #     'HostedZoneId': 'string',
                        #     'DNSName': 'string',
                        #     'EvaluateTargetHealth': True|False
                        # },
                        # 'HealthCheckId': 'string',
                        # 'TrafficPolicyInstanceId': 'string'
                    }
                }
            ]
        }
    )





#Notify via SNS Topic
def publish_to_notify_topic(targetInstance_ID, desired_hostname, public_IP):
    #lookup SNS Target ARN based on hostname or context variable
    arn = "arn:aws:sns:us-west-2:101845606311:Topic_for_notifications_for_owncloud_adrianws_com"
    host = desired_hostname
    instance = targetInstance_ID
    message = "THE DNS ENTRY INSTANCE ID: " + instance + " THAT HAS IP ADDRESS: " + public_IP + " has been updated to " + host
    please_wait_message = "  \n\n   Please allow at least 2 minutes for the changes to be propagated to your computer"
    message =  message + please_wait_message

    if DEBUG:
        print ""
        print message 
        print ""
    client_sns = boto3.client('sns')
    response = client_sns.publish(
        Subject="Message from the updateDNSRecord() Lambda Function",
        TargetArn=arn,
        Message=message
    )




def lambda_handler(event, context):

    print 'Running lambda_handler'

    #Find the instance
    targetInstance_ID = get_instance(event)
    
    #Get the Public IP
    public_IP, desired_hostname = get_public_IP_and_instance_hostname(targetInstance_ID)
    
    #Get the DNS/hostname to be updated
    # desired_hostname = get_instance_hostname(targetInstance_ID)

    #Update the hostname 
    update_instance_hostname(public_IP, desired_hostname)
    #UNCOMMENT THE ABOVE LINE TO REENABLE THE DNS UPDATES WHEN THE LOAD BALANCER IS DELETED.   :-) 
    #Notify via SNS Topic
    publish_to_notify_topic(targetInstance_ID, desired_hostname, public_IP)




# Update DNS for WHO (HOSTNAME) to WHAT (IP ADDRESS)
if __name__ == '__main__':
    print 'Running Locally?....'
    #Create test event
    # test_event = dict()
    test_event={u'account': u'101845606311', u'region': u'us-west-2', u'detail': {u'state': u'running', u'instance-id': u'i-0fbe1a6a8bbffb9d7'}, u'detail-type': u'EC2 Instance State-change Notification', u'source': u'aws.ec2', u'version': u'0', u'time': u'2017-06-03T03:53:02Z', u'id': u'9fd9ac5d-5e17-430d-aa6d-15ab47335b70', u'resources': [u'arn:aws:ec2:us-west-2:101845606311:instance/i-0fbe1a6a8bbffb9d7']}
    context = "not yet setup for local testing"
    lambda_handler(test_event,context)
else:
    print '__name__ !=__main__ So this is probably running in AWS'
    print 'ALERT:  You should NOT be seeing this Alert!!'


