# https://intersight.com/an/settings/api-keys/
## Generate API key to obtain the API Key and PEM file

variable "intersight_key" {
    description = "API Key for Intersight Account"
    type = string
    #default = "59af0e11f11aa10001678016/59af0ceef11aa100016748f0/61f043507564612d33eda2d3"
}

variable "intersight_secret" {
    description = "Filename (PEM) that provides secret key for Intersight API"
    type = string
    #default = "SecretKey.txt"
}

variable "endpoint" {
    description = "Intersight API endpoint"
    type = string
    default = "https://intersight.com"
}

variable "organization" {
    type = string
    default = "buffalo_dc"
}

