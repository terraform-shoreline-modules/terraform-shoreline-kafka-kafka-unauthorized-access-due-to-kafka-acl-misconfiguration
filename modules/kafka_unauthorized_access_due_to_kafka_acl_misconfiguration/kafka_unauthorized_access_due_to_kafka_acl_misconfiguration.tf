resource "shoreline_notebook" "kafka_unauthorized_access_due_to_kafka_acl_misconfiguration" {
  name       = "kafka_unauthorized_access_due_to_kafka_acl_misconfiguration"
  data       = file("${path.module}/data/kafka_unauthorized_access_due_to_kafka_acl_misconfiguration.json")
  depends_on = [shoreline_action.invoke_kafka_acl_check,shoreline_action.invoke_kafka_acl_update]
}

resource "shoreline_file" "kafka_acl_check" {
  name             = "kafka_acl_check"
  input_file       = "${path.module}/data/kafka_acl_check.sh"
  md5              = filemd5("${path.module}/data/kafka_acl_check.sh")
  description      = "Wrongly configured Kafka Access Control Lists (ACLs) that allow unauthorized access to sensitive Kafka resources."
  destination_path = "/agent/scripts/kafka_acl_check.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "kafka_acl_update" {
  name             = "kafka_acl_update"
  input_file       = "${path.module}/data/kafka_acl_update.sh"
  md5              = filemd5("${path.module}/data/kafka_acl_update.sh")
  description      = "Identify the misconfigured ACLs and update them to reflect the correct access permissions."
  destination_path = "/agent/scripts/kafka_acl_update.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_kafka_acl_check" {
  name        = "invoke_kafka_acl_check"
  description = "Wrongly configured Kafka Access Control Lists (ACLs) that allow unauthorized access to sensitive Kafka resources."
  command     = "`chmod +x /agent/scripts/kafka_acl_check.sh && /agent/scripts/kafka_acl_check.sh`"
  params      = ["PATH_TO_KAFKA_CONFIG_FILE","NAME_OF_SENSITIVE_KAFKA_RESOURCE"]
  file_deps   = ["kafka_acl_check"]
  enabled     = true
  depends_on  = [shoreline_file.kafka_acl_check]
}

resource "shoreline_action" "invoke_kafka_acl_update" {
  name        = "invoke_kafka_acl_update"
  description = "Identify the misconfigured ACLs and update them to reflect the correct access permissions."
  command     = "`chmod +x /agent/scripts/kafka_acl_update.sh && /agent/scripts/kafka_acl_update.sh`"
  params      = ["CORRECT_ACL_PERMISSIONS","MISCONFIGURED_ACL","PATH_TO_KAFKA_CONFIG"]
  file_deps   = ["kafka_acl_update"]
  enabled     = true
  depends_on  = [shoreline_file.kafka_acl_update]
}

