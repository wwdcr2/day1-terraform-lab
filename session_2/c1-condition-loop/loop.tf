# variable "user_list" {
#   default = [
#     { 
#       name = "alice",
#       team = "Security"
#     }, 
#     { 
#       name = "bob" 
#       team = "Security"
#     }, 
#     { 
#       name = "charlie"
#       team = "Guest"
#     },
#     {
#       name = "daisy"
#       team = "Development"
#     }
#   ]
# }

# locals {
#   user_capital_map = {
#     for i in var.user_list : upper(i.name) => i.team
#   }
# }

# output "user_map" {
#   value = local.user_capital_map
# }

# # locals { 
# #   employee_capital_map = {
# #     for i in var.user_list : upper(i.name) => i.team if i.team != "Guest"
# #   }
# # }

# # output "employee_map" {
# #   value = local.employee_capital_map
# # }