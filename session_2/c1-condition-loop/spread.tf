# locals {
#   tag_map = {
#     base_tags = {
#       env        = "prod",
#       created-by = "terraform"
#     },
#     project_tags = {
#       project = "management", 
#       cost-center = "mgmt-123"
#     }
#   }

#   tag_list  = [for tags in local.tag_map : tags]
  
#   # all_tag_list는 [{}, {}] 형태의 리스트 컬렉션이라 map을 병합하는 merge 함수의 argument로 적절하지 않지만, 
#   # spread (...)를 사용하여 list 내부 element(각 map)를 merge 함수의 argument로 전달한다.
#   all_tag_map = merge(local.tag_list...)
# }

# output "tag_list" {
#   value = local.tag_list
# }

# output "all_tag_map" {
#   value = local.all_tag_map
# }