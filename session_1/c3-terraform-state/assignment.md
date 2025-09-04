---
slug: terraform-state
id: ksyy7ykdludi
type: challenge
title: 'Challenge 3: Exploring Terraform State'
teaser: Use this challenge to explore two subcommands for the `terraform state` CLI
  feature.
notes:
- type: text
  contents: Use the `terraform state` command for advanced state management. Note
    that it is possible to destroy state, so always be knowledgeable of the commands
    you are using.
tabs:
- id: ngudmzjik2vf
  title: Shell
  type: terminal
  hostname: workstation
- id: 8beghvhnx6vm
  title: Code
  type: code
  hostname: workstation
  path: /root/code/terraform
difficulty: basic
timelimit: 6000
enhanced_loading: null
---

This challenge will provide a brief overview of the `terraform state` command. A more in-depth presentation is given in our "Terraform Foundations: State CLI" course.

Step 1: Listing State Information
===

You can use the `terraform state list` command to list all resources in the state file that results from a `terraform apply`.

1. Run the `terraform` command below in the [button label="Shell"](tab-0) tab to check out the resources that exist for the HashiCat project:

    ```bash,run
    terraform state list
    ```

    Your output should be equivalent to what is shown:

    ```bash,nocopy
    data.aws_ami.ubuntu
    aws_eip.hashicat
    aws_eip_association.hashicat
    aws_instance.hashicat
    aws_internet_gateway.hashicat
    aws_route_table.hashicat
    aws_route_table_association.hashicat
    aws_security_group.hashicat
    aws_subnet.hashicat
    aws_vpc.hashicat
    ```

Step 2: Show Single Resource Attributes
===

You can use the `terraform state show [options] '<ADDRESS>'` command to show the attributes of the resource specified, as described by the state file. Use the `<ADDRESS>` field to specify the resource.

1. For the HashiCat project, check out the `aws_vpc.hashicat` resource using the command provided:

    ```bash,run
    terraform state show 'aws_vpc.hashicat'
    ```

    The output should give you the attribute values of the `aws_vpc` resource called "hashicat":

    ```bash,nocopy
    # aws_vpc.hashicat:
    resource "aws_vpc" "hashicat" {
        arn                              = "arn:aws:ec2:us-east-1:735493809637:vpc/vpc-0cd93e12dac8c141b"
        assign_generated_ipv6_cidr_block = false
        cidr_block                       = "10.0.0.0/16"
        default_network_acl_id           = "acl-0da9094066bc85fdd"
        default_route_table_id           = "rtb-0cc3632a63a2601c7"
        default_security_group_id        = "sg-004dd25f076d6c198"
        dhcp_options_id                  = "dopt-062899133eef8afae"
        enable_classiclink               = false
        enable_classiclink_dns_support   = false
        enable_dns_hostnames             = true
        enable_dns_support               = true
        id                               = "vpc-0cd93e12dac8c141b"
        instance_tenancy                 = "default"
        ipv6_association_id              = null
        ipv6_cidr_block                  = null
        main_route_table_id              = "rtb-0cc3632a63a2601c7"
        owner_id                         = "735493809637"
        tags                             = {
            "environment" = "Production"
            "name"        = "academy-vpc-us-east-1"
        }
        tags_all                         = {
            "environment" = "Production"
            "name"        = "academy-vpc-us-east-1"
        }
    }
    ```

Click the <a href="#" onclick="return false;">button label="Check" variant="success"</a> button below to continue.
