# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables
# ---------------------------------------------------------------------------------------------------------------------

# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY

# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "example" {
  description = "Example variable"
  default     = "example"
}

variable "example2" {
  description = "Example variable 2"
  default     = ""
}

variable "example_list" {
  description = "An example variable that is a list."
  type        = "list"
  default     = []
}

variable "example_map" {
  description = "An example variable that is a map."
  type        = "map"
  default     = {}
}
