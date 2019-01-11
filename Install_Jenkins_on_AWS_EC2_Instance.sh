# Install Jenkins on AWS EC2 instance 
# https://pkg.jenkins.io/redhat/
# https://d1.awsstatic.com/Projects/P5505030/aws-project_Jenkins-build-server.pdf
# https://d1.awsstatic.com/Projects/P5505030/aws-project_Jenkins-build-server.pdf
# https://gist.github.com/diegopacheco/6d69e0cfaf13d4351cfa700bb4af8172
# https://www.youtube.com/watch?v=uu5XcU4EPzQ


sudo yum update

sudo yum remove -y java

sudo yum install java-1.8.0

sudo yum install java-1.8.0-openjdk

sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key

sudo yum install jenkins

sudo service jenkins start

sudo cat /var/lib/jenkins/secrets/initialAdminPassword


# Connect to http://<your_server_public_DNS>:8080 



# aws sns publish --topic-arn "arn:aws:sns:us-west-2:101845606311:AdrianTopic1" --message "Jenkins build is starting"


# Note:  For HTTPS, use an Elastic Load Balancer listening with a certificate on port 8080