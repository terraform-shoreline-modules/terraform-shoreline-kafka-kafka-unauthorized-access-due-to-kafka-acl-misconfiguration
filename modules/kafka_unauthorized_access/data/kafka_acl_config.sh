

#!/bin/bash



# Set the Kafka configuration file path

KAFKA_CONFIG_FILE=${KAFKA_CONFIG_FILE}



# Set the authorized user list

AUTHORIZED_USERS=${AUTHORIZED_USERS}



# Backup the existing Kafka configuration file

cp $KAFKA_CONFIG_FILE $KAFKA_CONFIG_FILE.bak



# Update the Kafka ACL configuration to limit access to only authorized users

sed -i 's/^.*allow.*$/allow='$AUTHORIZED_USERS'/' $KAFKA_CONFIG_FILE



# Restart the Kafka service

systemctl restart kafka.service



# Verify that the configuration changes are effective

kafka-acls --list --authorizer-properties zookeeper.connect=localhost:2181 --topic test-topic