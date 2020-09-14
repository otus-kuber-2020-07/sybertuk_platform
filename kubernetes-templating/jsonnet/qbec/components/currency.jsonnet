

local p = import '../params.libsonnet';
local params = p.components.currency;

local env = {
  name: std.extVar('qbec.io/env'),
};

[
    {
        apiVersion: 'v1',
        kind: 'Service',
        metadata: {
            name: 'currencyservice',
            namespace: params.Namespace,
        },
        spec: {
            type: 'ClusterIP',
            selector: {
                app: 'currencyservice',
            },
            ports: [
            {
                name: 'grpc',
                port: params.Port,
                targetPort: params.Port,
            },
            ],
        },
    },
    {
        apiVersion: 'apps/v1',
        kind: 'Deployment',
        metadata: {
            name: 'currencyservice',
            namespace: params.Namespace,
        },
        spec: {
            selector: {
                matchLabels: {
                    app: 'currencyservice',
                },
            },
            template: {
                metadata: {
                    labels: {
                        app: 'currencyservice',
                    },
                },
            spec: {
                containers: [
                    {
                    name: 'server',
                    image: 'gcr.io/google-samples/microservices-demo/currencyservice:v0.1.3',
                    ports: [
                    {
                        name: 'grpc',
                        containerPort: 7000,
                    },
                    ],
                    env: [ 
                    {
                          name: 'PORT',
                          value: '7000',
                    },
                    ],
                    readinessProbe: {
                        exec: {
                            command: ["/bin/grpc_health_probe", "-addr=:7000"],
                        },
                    },
                    livenessProbe: {
                        exec: {
                            command: ["/bin/grpc_health_probe", "-addr=:7000"],
                        },
                    },
                    resources: {
                        requests: {
                            cpu: '100m',
                            memory: '64Mi',
                        },
                        limits: {
                            cpu: '200m',
                            memory: '128Mi',
                        },
                    },
                },
                ],
        },
    },
    },
    },
]

