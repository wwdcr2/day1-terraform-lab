---
slug: terraform-init-fmt
id: tsukyqpnpclq
type: challenge
title: 'Challenge 1: Terraform CLI 소개'
teaser: 이 챌린지에서는 Terraform CLI의 기본적인 명령어 Init 과정을 소개합니다.
notes:
- type: text
  contents: Terraform CLI는 `terraform` 명령을 의미합니다. Terraform CLI에 내장된 인라인 도움말에는 각 명령의 가장 중요한 특징이 설명되어 있습니다.
tabs:
- id: jimtmq7ncyhu
  title: Shell
  type: terminal
  hostname: workstation
- id: ngh4mh16x7o8
  title: Code
  type: code
  hostname: workstation
  path: /root/code/terraform
difficulty: basic
timelimit: 6000
enhanced_loading: null
---

[Terraform 명령줄 인터페이스(CLI)](https://developer.hashicorp.com/terraform/cli)는 Terraform Community Edition, HCP Terraform, Terraform Enterprise의 대부분 기능과 상호작용하는 데 사용할 수 있는 강력한 도구입니다. 이는 Terraform이 인프라를 프로비저닝하기 위해 수행하는 작업과 plan 및 apply의 결과를 이해하는 데 도움이 됩니다.

CLI는 `terraform` 명령어와 다양한 하위 명령어들로 구성됩니다. 이러한 명령어 중 일부는 다음 실습에서 탐색할 예정입니다.

실습 시작 전에 Terraform 프로젝트가 생성되었습니다. 이 프로젝트는 "HashiCat"이라고 불립니다. HashiCat 코드는 [button label="Code"](tab-1) 탭에서 볼 수 있습니다. Terraform CLI도 설치되어 있습니다.

> [!IMPORTANT]
> Terraform CLI를 처음 사용하려면 설치해야 합니다. 이 과정에 익숙하지 않다면 [Terraform 설치 튜토리얼](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)을 따라하세요.

1단계: Terraform CLI 검증
===

1. Terraform CLI가 설치되었는지 확인하려면 [button label="Shell"](tab-0) 탭을 사용하여 다음 명령어를 실행하세요:

    ```bash,run
    terraform
    ```

    하위 명령어 목록이 표시됩니다:

    ```bash,nocopy
    Usage: terraform [global options] <subcommand> [args]

    The available commands for execution are listed below.
    The primary workflow commands are given first, followed by
    less common or more advanced commands.

    Main commands:
      init          Prepare your working directory for other commands
      validate      Check whether the configuration is valid
      plan          Show changes required by the current configuration
      apply         Create or update infrastructure
      destroy       Destroy previously-created infrastructure
    ...
    ```

다음을 실행하여 이러한 하위 명령어에 대한 정보를 얻을 수 있습니다:

`terraform <subcommand> -help`

2단계: "terraform init" 실행
===

Terraform은 구성 파일이 포함된 작업 디렉토리에서 호출되어야 합니다. 이러한 파일들은 Terraform 언어로 작성되어야 하며 `.tf` 파일 확장자로 표시됩니다.

Terraform이 작업 디렉토리에서 작업을 수행하기 전에 작업 디렉토리를 초기화해야 합니다. 초기화 후에는 다른 명령어들을 수행할 수 있습니다.

1. 다음 명령어를 실행하세요:

    ```bash,run
    terraform init
    ```

    다음과 같은 출력이 제공되어야 합니다:

    ```bash,nocopy
    Terraform has been successfully initialized!

    You may now begin working with Terraform. Try running "terraform plan" to see
    any changes that are required for your infrastructure. All Terraform commands
    should now work.

    If you ever set or change modules or backend configuration for Terraform,
    rerun this command to reinitialize your working directory. If you forget, other
    commands will detect it and remind you to do so if necessary.
    ```

이는 이제 작업 디렉토리에서 Terraform을 사용하여 리소스를 조작할 수 있음을 알려줍니다.

> [!IMPORTANT]
> 특정 유형의 Terraform 구성 변경 사항(프로바이더 요구사항 업데이트, 모듈 버전 제약 조건 또는 백엔드 구성 등)은 재초기화가 필요합니다. `terraform init`을 다시 실행하여 디렉토리를 재초기화하세요.

> [!NOTE]
> `terraform init`은 언제든지 실행할 수 있습니다. `init` 명령어는 멱등성을 가지며, 변경 사항이 감지되지 않으면 Terraform 구성에 영향을 주지 않습니다.

2. 다음 명령어를 실행하여 생성된 파일들을 확인하세요:

    ```bash,run
    ls -la
    ```

    다음과 같이 `.terraform`, `.terraform.lock.hcl` 파일이 추가된 것을 확인할 수 있습니다.
    ```bash,nocopy
    total 36
    drwxr-xr-x 3 root root 4096 Sep  4 04:53 .
    drwxr-xr-x 3 root root 4096 Sep  4 04:53 ..
    drwxr-xr-x 3 root root 4096 Sep  4 04:53 .terraform
    -rw-r--r-- 1 root root 1106 Sep  4 04:53 .terraform.lock.hcl
    -rw-r--r-- 1 root root  533 Sep  4 04:53 bootstrap
    -rw-r--r-- 1 root root 2661 Sep  4 04:53 main.tf
    -rw-r--r-- 1 root root  161 Sep  4 04:53 outputs.tf
    -rw-r--r-- 1 root root  116 Sep  4 04:53 terraform.tf
    -rw-r--r-- 1 root root 1597 Sep  4 04:53 variables.tf
    ```

    [button label="Code"](tab-1) 탭을 새로고침하고 생성된 `.terraform.lock.hcl` 파일을 보면 provider의 버전을 확인할 수 있습니다.

    또한 `.terraform` 폴더 아래에 aws provider가 생성된 것을 볼 수 있습니다.

3단계: "terraform fmt" 확인
===

`terraform fmt` 명령어는 Terraform 코드에 표준 형식과 스타일을 적용하는 데 사용됩니다. 이 명령어는 가독성을 위한 기타 사소한 조정과 함께 [Terraform 언어 스타일 규칙](https://developer.hashicorp.com/terraform/language/style#code-formatting)의 하위 집합을 적용합니다.

1. [button label="Code"](tab-1) 탭에서 `variables.tf` 파일에 부적절하게 배치된 몇 가지 변수 선언이 있는 것을 볼 수 있습니다.

2. [button label="Shell"](tab-0) 탭에서 `fmt` 명령어를 실행하세요.

    ```bash,run
    terraform fmt
    ```

3. `variables.tf` 파일을 다시 확인하여 코드가 어떻게 적절히 포맷되었는지 확인하세요.

> [!NOTE]
> 파일 업데이트를 보려면 워크스테이션 파일 탐색기 메뉴에서 새로고침 버튼을 눌러야 할 수도 있습니다.

4단계: "terraform validate" 시도
===

`terraform validate` 명령어는 제공된 변수나 기존 상태에 관계없이 구성 파일이 구문적으로 유효하고 내부적으로 일관성이 있는지 확인합니다.

이 명령어는 자동으로 실행해도 안전합니다. `-json` 플래그를 사용하여 검증 결과를 JSON 형식으로 생성할 수 있으며, 이는 도구 통합에 유용할 수 있습니다.

1. [button label="Shell"](tab-0) 탭을 사용하여 HashiCat 프로젝트에서 `-json` 플래그를 사용했을 때의 출력 결과를 확인하세요:

    ```bash,run
    terraform validate -json
    ```

    이 경우 출력은 파일이 유효함을 알려줍니다.

    ```bash,nocopy
    {
      "format_version": "1.0",
      "valid": true,
      "error_count": 0,
      "warning_count": 0,
      "diagnostics": []
    }
    ```

계속하려면 아래의 <a href="#" onclick="return false;">button label="Check" variant="success"</a> 버튼을 클릭하세요.
