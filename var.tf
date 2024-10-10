# variable "resource_group_name" {
#   description = "Name of the resource group"
#   type        = string
# }

variable "location" {
  description = "Resource group location"
  type        = string
}

variable "os_type" {
  description = "The O/S type for the App Services to be hosted in this plan. Possible values include Windows, Linux, and WindowsContainer"
  type        = string
}

variable "sku_name" {
  description = "The SKU for the plan. Possible values include B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I2v2, I3v2, I4v2, I5v2, I6v2, P1v2, P2v2, P3v2, P0v3, P1v3, P2v3, P3v3, P1mv3, P2mv3, P3mv3, P4mv3, P5mv3, S1, S2, S3, SHARED, EP1, EP2, EP3, WS1, WS2, WS3, and Y1."
  type        = string
}

#--------------------------------------------------optional--------------------------------------------------------------------------------------#
variable "app_service_environment_id" {
  description = "The ID of the App Service Environment to create this Service Plan in"
  type        = string
  default     = null
}

variable "maximum_elastic_worker_count" {
  description = "The maximum number of workers to use in an Elastic SKU Plan. Cannot be set unless using an Elastic SKU"
  type        = number
  default     = null
}

variable "worker_count" {
  description = "The number of Workers (instances) to be allocated"
  type        = number
  default     = 3
}

variable "per_site_scaling_enabled" {
  description = "Should Per Site Scaling be enabled. Defaults to false."
  type        = bool
  default     = false
}

variable "zone_balancing_enabled" {
  description = "Should the Service Plan balance across Availability Zones in the region. Defaults to false"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags which should be assigned to the AppService"
  type        = map(string)
}
