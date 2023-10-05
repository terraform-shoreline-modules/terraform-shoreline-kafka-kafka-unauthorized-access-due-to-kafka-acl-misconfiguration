

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