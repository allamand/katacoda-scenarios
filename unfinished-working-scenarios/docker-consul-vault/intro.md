

In this scenario, we'll explore how to store secrets in Hashicorp Vault. The scenario explains how to initialise a vault, store key/values in a secure way that can later be accessed via the CLI or the HTTP API. The HTTP API is an excellent way to obtain secrets when running inside a Docker Container.




## What is Hashicorp Vault

Vault is a tool for securely accessing secrets. A secret is anything that you want to tightly control access to, such as API keys, passwords, certificates, and more. Vault provides a unified interface to any secret, while providing tight access control and recording a detailed audit log. More details can be found at https://github.com/hashicorp/vault/

## Important

This scenario is designed for educational purposes and not production. For production usage, you should always use TLS which has been disabled in this example.
and a 3 consul instances on differents nodes, instead of just one local instance

