
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Kafka Unauthorized Access Due to Kafka ACL Misconfiguration.
---

This incident type refers to unauthorized access to a Kafka cluster due to misconfigured Access Control Lists (ACLs). Kafka is a distributed messaging system used to store and process large data streams in real-time. Access to the Kafka cluster is controlled by ACLs, which specify which users or applications have permission to read, write, or modify data in the cluster. Misconfigurations in ACLs can lead to unauthorized access to the cluster, which can compromise sensitive data or disrupt the system's functionality. It is essential to ensure that proper security measures are in place to prevent unauthorized access to the Kafka cluster.

### Parameters
```shell
export PATH_TO_KAFKA_CONFIG="PLACEHOLDER"

export PATH_TO_KAFKA_CONFIG_FILE="PLACEHOLDER"

export CORRECT_ACL_PERMISSIONS="PLACEHOLDER"

export MISCONFIGURED_ACL="PLACEHOLDER"

export NAME_OF_SENSITIVE_KAFKA_RESOURCE="PLACEHOLDER"
```

## Debug

### Check if Kafka processes are running
```shell
sudo systemctl status kafka
```

### Check the Kafka logs for any errors
```shell
sudo tail -f /var/log/kafka/server.log
```

### Check the Kafka broker configuration
```shell
sudo cat ${PATH_TO_KAFKA_CONFIG}/server.properties
```

### Check the Kafka ACL configuration
```shell
sudo cat ${PATH_TO_KAFKA_CONFIG}/kafka-acls.properties
```

### Check the permissions on Kafka configuration files
```shell
sudo ls -l ${PATH_TO_KAFKA_CONFIG}
```

### Check if any unauthorized access attempts have been made
```shell
sudo grep "Unauthorized access" /var/log/kafka/server.log
```

### Check the user and group ownership of Kafka configuration files
```shell
sudo ls -l ${PATH_TO_KAFKA_CONFIG} | awk '{print $3, $4}'
```

### Check the network connections to Kafka brokers
```shell
sudo netstat -tulpn | grep kafka
```

### Check if any unauthorized users have logged in
```shell
sudo grep "authentication failure" /var/log/auth.log
```

### Wrongly configured Kafka Access Control Lists (ACLs) that allow unauthorized access to sensitive Kafka resources.
```shell


#!/bin/bash



# Set variables

KAFKA_CONFIG_FILE=${PATH_TO_KAFKA_CONFIG_FILE}

SENSITIVE_RESOURCE=${NAME_OF_SENSITIVE_KAFKA_RESOURCE}



# Check Kafka ACL configuration

if grep -q "${SENSITIVE_RESOURCE}" "${KAFKA_CONFIG_FILE}" && grep -q "allow" "${KAFKA_CONFIG_FILE}"; then

    echo "ACLs are allowing access to ${SENSITIVE_RESOURCE}."

    exit 1

fi



echo "ACLs are properly configured and not allowing unauthorized access to ${SENSITIVE_RESOURCE}."

exit 0


```

## Repair

### Identify the misconfigured ACLs and update them to reflect the correct access permissions.
```shell


#!/bin/bash



# Set variables

KAFKA_CONFIG_FILE=${PATH_TO_KAFKA_CONFIG}

ACL_TO_UPDATE=${MISCONFIGURED_ACL}



# Identify the misconfigured ACL

MISCONFIGURED_ACL=$(grep "$ACL_TO_UPDATE" "$KAFKA_CONFIG_FILE")



# Update the ACL with the correct access permissions

CORRECT_ACL=${CORRECT_ACL_PERMISSIONS}

sed -i "s/$MISCONFIGURED_ACL/$CORRECT_ACL/g" "$KAFKA_CONFIG_FILE"



# Restart Kafka to apply the changes

systemctl restart kafka


```