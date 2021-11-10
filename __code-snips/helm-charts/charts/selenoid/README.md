# Selenoid Server and UI chart

## Server configuration

Parameter | Description | Default
--- | --- | ---
`name` | Server deployment name | `selenoid-server`
`image.repository` | Image | `aerokube/selenoid`
`image.tag` | Image tag | `latest`
`image.pullPolicy` | Image tag | `Always`
`service.nodePort` | Port to expose Service on each node | `34444`
`service.type` | Service type | `NodePort`

## UI configuration

Parameter | Description | Default
--- | --- | ---
`ui.name` | Server deployment name | `selenoid-ui`
`ui.image.repository` | Image | `aerokube/selenoid-ui`
`ui.image.tag` | Image tag | `latest`
`ui.image.pullPolicy` | Image tag | `Always`
`ui.service.nodePort` | Port to expose Service on each node | `34445`
`ui.service.type` | Service type | `NodePort`

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.