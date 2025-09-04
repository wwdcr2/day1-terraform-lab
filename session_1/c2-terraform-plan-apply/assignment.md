---
slug: terraform-plan-apply
id: tkeyztwuttlp
type: challenge
title: '챌린지 2: Terraform Plan과 Apply'
teaser: 이 챌린지는 Terraform 코드가 정의하는 리소스를 계획하고 적용하는 방법을 보여줍니다.
notes:
- type: text
  contents: Terraform의 주요 기능은 원하는 상태와 일치하도록 인프라 리소스를 생성, 수정, 삭제하는 것입니다. 여기서는 생성을 위한 CLI 옵션을 탐색할 것입니다.
tabs:
- id: 9zyjinkqxlb8
  title: Shell
  type: terminal
  hostname: workstation
- id: tdumu4gdgok7
  title: Code
  type: code
  hostname: workstation
  path: /root/code/terraform
difficulty: basic
timelimit: 6000
enhanced_loading: null
---

2. plan apply
  - plan -out "HashiCatPlan.tfplan" 파일 생성 시도
    - variable에 validation error 유발
    - 다른 tfvar 파일을 사용하도록 유도
    - 수정후 plan 시도
  - 생성한 plan 파일을 show로 확인
  - apply로 plan 파일을 apply

type and validation 부분 추가?



Terraform 코드가 포맷되고 검증되었으므로, 이제 구성 파일에 정의된 인프라를 프로비저닝할 시간입니다. 이는 `terraform plan`과 `terraform apply` 명령어를 사용하여 수행할 수 있습니다.

1단계: "terraform plan"으로 미리 계획하기
===

`terraform plan`을 사용하면 실제로 변경이 이루어지기 전에 Terraform이 인프라에 시도할 모든 변경 사항을 미리 볼 수 있습니다. 이를 추측 계획(speculative plan)이라고 하며, Terraform을 "dry" 모드로 실행하는 것과 같습니다. 기본적으로 Terraform이 계획을 생성할 때:

- 이미 존재하는 객체의 현재 상태를 읽습니다(존재하는 경우). 이는 상태가 최신인지 확인합니다.
- 현재 구성을 이전 상태와 비교하고 차이점을 기록합니다.
- 적용될 경우 원격 객체가 기존 구성과 일치하도록 하는 변경 사항 집합을 제안합니다.

생성된 계획을 나중에 `apply` 단계에서 사용할 수 있는 파일로 저장할 수 있습니다. 이는 필수는 아니지만 자동화된 워크플로에서 유용합니다.

1. [button label="Shell"](tab-0) 탭에서 다음 명령어를 실행하여 계획을 "HashiCatPlan.tfplan"이라는 파일로 저장하세요:

    ```bash,run
    terraform plan -out "HashiCatPlan.tfplan"
    ```

    여기서 에러가 발생할 것입니다.

    ```bash,nocopy
    Planning failed. Terraform encountered an error while generating this plan.

    ╷
    │ Error: Invalid value for variable
    │ 
    │   on variables.tf line 20:
    │   20: variable "address_space" {
    │     ├────────────────
    │     │ var.address_space is "10.0.0.0"
    │ 
    │ variable address_space must be valid IPv4 CIDR.
    │ 
    │ This was checked by the validation rule at variables.tf:24,3-13.
    ╵
    ```

    plan시에 validation 항목을 체크하며 에러가 발생한 것입니다.

    Terraform은 [Input Variables](https://developer.hashicorp.com/terraform/language/values/variables) 문서의 아래 내용처럼 별도의 명시 없이도 기본적으로 몇몇 tfvars 파일을 로드합니다.
    
    ```
    Terraform also automatically loads a number of variable definitions files if they are present:

    Files named exactly `terraform.tfvars` or `terraform.tfvars.json`.
    Any files with names ending in `.auto.tfvars` or `.auto.tfvars.json`.
    ```

2. tfvars 수정 혹은 파일을 제거하여 default 값 사용

    [button label="Code"](tab-1) 탭에서 `terraform.tfvars` 파일의 `address_space` 값을 적절하게 수정합니다.

    혹은 아래의 명령어로 tfvars 파일을 제거하여 variable의 default 값을 사용하게끔 만들어줍니다.

    ```bash,run
    rm terraform.tfvars
    ```

3. 다시 [button label="Shell"](tab-0) 탭에서 다음 명령어를 실행하여 계획을 "HashiCatPlan.tfplan"이라는 파일로 저장하세요:

    어떤 변경 사항이 이루어질지와 계획이 성공적으로 저장되었음을 알려주는 다음과 같은 출력을 받아야 합니다:

    ```bash,nocopy
    Plan: 9 to add, 0 to change, 0 to destroy.

    Changes to Outputs:
      + catapp_ip  = (known after apply)
      + catapp_url = (known after apply)

    ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

    Saved the plan to: HashiCatPlan.tfplan

    To perform exactly these actions, run the following command to apply:
        terraform apply "HashiCatPlan.tfplan"
    ```

2단계: 계획 파일 보기
===

1. 다음 명령어를 실행하여 계획 파일의 내용을 검토할 수 있습니다:

    ```bash,run
    terraform show "HashiCatPlan.tfplan"
    ```

3단계: 실제 세상에 변화 만들기
===

계획이 검증되었으므로, 이제 HashiCat 프로젝트에 정의된 인프라를 프로비저닝할 시간입니다.

1. 아래의 `terraform apply` 명령어를 실행하여 "HashiCatPlan.tfplan" 파일을 사용하고 원하는 인프라를 생성하세요:

    ```bash,run
    terraform apply "HashiCatPlan.tfplan"
    ```

    이 생성 단계는 시간이 걸릴 수 있으므로 필요하다면 일어나서 스트레칭을 해도 됩니다.

> [!NOTE]
> 계획 파일을 사용할 때는 변경 사항을 승인하라는 요청을 받지 않습니다. 단순히 `terraform apply`를 실행하면 'yes'를 입력하여 구성 변경을 확인해야 합니다.

아래 출력을 보면 다음 챌린지로 넘어갈 준비가 된 것입니다:

```bash,nocopy
Apply complete! Resources: 9 added, 0 changed, 0 destroyed.

Outputs:

catapp_ip = "http://54.84.208.123"
catapp_url = "http://ec2-54-84-208-123.compute-1.amazonaws.com"
```

계속하려면 아래의 <a href="#" onclick="return false;">button label="Check" variant="success"</a> 버튼을 클릭하세요.
