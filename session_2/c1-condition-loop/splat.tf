# variable "user2_list" {
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
#   user_name_list       = [ for i in var.user2_list : i.name ]
#   splat_user_name_list = var.user2_list[*].name
# }

# output "compare_variable" {
#   value = local.user_name_list == local.splat_user_name_list ? "두 로컬 변수 값이 동일합니다." : "두 로컬 변수 값에 차이가 있습니다."
# }

# # 주석을 해제하여 직접 로컬 변수 값을 확인할 수 있습니다.
# # output "user_name_list" {
# #   value = local.user_name_list
# # }

# # output "splat_user_name_list" {
# #   value = local.splat_user_name_list
# # }