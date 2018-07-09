#!/bin/bash

# Install awslogs and the jq JSON parser
yum install -y awslogs jq

# Inject the CloudWatch Logs configuration file contents
cat > /etc/awslogs/awslogs.conf <<- EOF
[general]
state_file = /var/lib/awslogs/agent-state

[/var/log/dmesg]
file = /var/log/dmesg
log_group_name = /${cloudwatch_log_group_prefix}/var/log/dmesg
log_stream_name = {cluster}/{private_ip}

[/var/log/messages]
file = /var/log/messages
log_group_name = /${cloudwatch_log_group_prefix}/var/log/messages
log_stream_name = {cluster}/{private_ip}
datetime_format = %b %d %H:%M:%S

[/var/log/docker]
file = /var/log/docker
log_group_name = /${cloudwatch_log_group_prefix}/var/log/docker
log_stream_name = {cluster}/{private_ip}
datetime_format = %Y-%m-%dT%H:%M:%S.%f

[/var/log/ecs/ecs-init.log]
file = /var/log/ecs/ecs-init.log
log_group_name = /${cloudwatch_log_group_prefix}/var/log/ecs/ecs-init.log
log_stream_name = {cluster}/{private_ip}
datetime_format = %Y-%m-%dT%H:%M:%SZ

[/var/log/ecs/ecs-agent.log]
file = /var/log/ecs/ecs-agent.log.*
log_group_name = /${cloudwatch_log_group_prefix}/var/log/ecs/ecs-agent.log
log_stream_name = {cluster}/{private_ip}
datetime_format = %Y-%m-%dT%H:%M:%SZ

[/var/log/ecs/audit.log]
file = /var/log/ecs/audit.log.*
log_group_name = /${cloudwatch_log_group_prefix}/var/log/ecs/audit.log
log_stream_name = {cluster}/{private_ip}
datetime_format = %Y-%m-%dT%H:%M:%SZ
EOF