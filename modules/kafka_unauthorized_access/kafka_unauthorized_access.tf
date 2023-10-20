resource "shoreline_notebook" "kafka_unauthorized_access" {
  name       = "kafka_unauthorized_access"
  data       = file("${path.module}/data/kafka_unauthorized_access.json")
  depends_on = [shoreline_action.invoke_kafka_acl_config]
}

resource "shoreline_file" "kafka_acl_config" {
  name             = "kafka_acl_config"
  input_file       = "${path.module}/data/kafka_acl_config.sh"
  md5              = filemd5("${path.module}/data/kafka_acl_config.sh")
  description      = "Check and review the Kafka ACL configuration to ensure that permissions are set up correctly for the intended users and groups. You may need to update the configuration to limit access to only authorized users and groups."
  destination_path = "/tmp/kafka_acl_config.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_kafka_acl_config" {
  name        = "invoke_kafka_acl_config"
  description = "Check and review the Kafka ACL configuration to ensure that permissions are set up correctly for the intended users and groups. You may need to update the configuration to limit access to only authorized users and groups."
  command     = "`chmod +x /tmp/kafka_acl_config.sh && /tmp/kafka_acl_config.sh`"
  params      = ["AUTHORIZED_USERS","KAFKA_CONFIG_FILE"]
  file_deps   = ["kafka_acl_config"]
  enabled     = true
  depends_on  = [shoreline_file.kafka_acl_config]
}

