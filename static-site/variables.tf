variable "cnameList" {
    type = list
    description = "Lista de CNAMEs da distribuição"
    default = null
}

variable "bucketName" {
    type = string
    description = "Nome do bucket da distribuição"
}

variable "repoNameAndOrg" {
    type = string
    description = "org/repoName para OIDC role"
}

variable "accountId" {
    type = string
    description = "ID da conta que receberá o recurso"
    
}

variable "project" {
    type = string
    description = "Nome do projeto"
}