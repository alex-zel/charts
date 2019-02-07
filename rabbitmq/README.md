# RabbitMQ
Helm chart to install a RabbitMQ cluster, can be installed using deployment (ip peer discovery) or statefulset (hostname peer discovery)

## Configuration

The following table lists the configurable parameters of the rabbitmq chart and their default values.

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `statefulset` | Whether to create a statefulset or deployment | `true` |
| `rabbitmqUsername` | RabbitMQ application username | `guest` |
| `rabbitmqPassword` | RabbitMQ application password | `""` |
| `managementUsername` | Management user username | `management` |
| `managementPassword` | Management user password | `""` |
| `podManagementPolicy` | Whether the pods should be restarted in parallel or one at a time. Either OrderedReady or Parallel. | `OrderedReady` |
| `updateStrategy` | Statefulset update strategy | `OnDelete` |
| `replicaCount` | Number of replicas | `3` |
| `rabbitmqVhost` | RabbitMQ application vhost | `/` |
| `rabbitmq_config` | Additional configuration to add to default configmap | `{}` |
| `plugins` | Additional plugins to add to the default configmap | `[]` |
| `amqpPort` | RabbitMQ amqp port | `5672` |
| `managerPort` | RabbitMQ management port | `15672` |
| `definitions.users` | Additional users | `[]` |
| `definitions.vhosts` | Additional vhosts | `[]` |
| `definitions.parameters` | Additional parameters | `[]` |
| `definitions.permissions` | Additional permissions | `[]` |
| `definitions.queues` | Pre-created queues | `[]` |
| `definitions.exchanges` | Pre-created exchanges | `[]` |
| `definitions.bindings` | Pre-created bindings | `[]` |
| `definitions.policies` | HA policies to add to definitions.json | `[]` |
