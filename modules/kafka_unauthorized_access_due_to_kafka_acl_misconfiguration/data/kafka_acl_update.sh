

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