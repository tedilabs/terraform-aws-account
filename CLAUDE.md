# CLAUDE.md — tedilabs/terraform-aws-* Modules

이 문서는 `tedilabs` 조직 하의 모든 `terraform-aws-*` 레포지토리에 공통으로 적용되는 코드 컨벤션, 아키텍처 패턴, 그리고 개발 가이드라인을 정의합니다.

## 프로젝트 개요

tedilabs의 Terraform AWS 모듈 컬렉션은 AWS 리소스를 관리하기 위한 재사용 가능한 Terraform 모듈 패키지입니다. 29개의 레포지토리에 걸쳐 160개 이상의 모듈이 존재하며, 각 레포는 특정 AWS 서비스 도메인을 담당합니다.

- 라이선스: Apache License 2.0
- 메인테이너: @posquit0 (Byungjin Park)

## 레포지토리 구조

모든 레포는 동일한 디렉토리 구조를 따릅니다:

```
terraform-aws-<domain>/
├── VERSION                         # 시맨틱 버전 (예: 1.2.2)
├── README.md
├── LICENSE
├── .editorconfig
├── .gitignore
├── .tflint.hcl
├── .pre-commit-config.yaml
├── .github/
│   ├── CODEOWNERS
│   ├── workflows/
│   │   ├── terraform.integration.yaml
│   │   └── ...
│   ├── dependabot.yml
│   └── ...
├── modules/
│   ├── <module-a>/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── versions.tf
│   │   ├── resource-group.tf
│   │   ├── README.md              # terraform-docs 자동 생성
│   │   ├── migrations.tf          # (선택) state migration 블록
│   │   └── <feature>.tf           # (선택) 기능별 분리 파일
│   └── <module-b>/
│       └── ...
└── examples/
    └── <example-name>/
        ├── main.tf
        ├── outputs.tf
        └── versions.tf
```

## 모듈 파일 구성

### versions.tf

Terraform 및 프로바이더 버전 제약조건을 정의합니다.

```hcl
terraform {
  required_version = ">= 1.12"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.12"
    }
  }
}
```

- `required_version`: 최소 Terraform 버전. 모듈에 따라 `>= 1.6` ~ `>= 1.12` 범위
- `required_providers`: AWS 프로바이더 필수. 필요시 `tls`, `kubernetes` 등 추가 프로바이더 선언
- 사용하지 않는 프로바이더가 선언된 경우 `# tflint-ignore: terraform_unused_required_providers` 주석 사용

### main.tf

모듈의 핵심 리소스를 정의합니다. 반드시 파일 상단에 `locals` 블록으로 시작합니다.

```hcl
locals {
  metadata = {
    package = "terraform-aws-<domain>"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = var.name
  }
  module_tags = var.module_tags_enabled ? {
    "module.terraform.io/package"   = local.metadata.package
    "module.terraform.io/version"   = local.metadata.version
    "module.terraform.io/name"      = local.metadata.module
    "module.terraform.io/full-name" = "${local.metadata.package}/${local.metadata.module}"
    "module.terraform.io/instance"  = local.metadata.name
  } : {}
}
```

- 첫 번째 `locals` 블록: `metadata` + `module_tags` (모든 모듈에서 동일)
- 두 번째 `locals` 블록: 서비스별 매핑 값, 계산된 값

### variables.tf

모든 변수 정의를 포함합니다.

**변수 문서화 패턴:**
- `(Required)` 또는 `(Optional)` 접두사를 description에 명시
- 복잡한 object 타입은 heredoc (`<<EOF...EOF`) 활용하여 중첩 필드를 문서화
- 유효한 값이 제한된 경우 description에 명시하고 `validation` 블록으로 검증
- 기본값이 있으면 description에 `Defaults to <value>.` 형태로 기재

**공통 변수 (모든 모듈에 존재):**
- `name` - 리소스 이름 (Required)
- `tags` - 태그 맵 (Optional, default: `{}`)
- `module_tags_enabled` - 모듈 태그 생성 여부 (Optional, default: `true`)
- `resource_group` - AWS Resource Group 설정 (Optional)

**변수 속성 규칙:**
- 필수 변수: `nullable = false`, `default` 없음
- 선택 변수: `nullable = false`, `default` 지정 (보통 `{}`, `[]`, `false` 등)
- null 허용 변수: `nullable = true` (주로 `region` 등 provider 위임 변수)

### outputs.tf

**표준 출력 (대부분의 모듈에 존재):**
- `region`, `name`, `id`, `arn`

**조건부 출력 패턴:**
```hcl
output "<feature>" {
  description = "..."
  value = (var.<feature>.enabled
    ? { /* 상세 값 */ }
    : null
  )
}
```

### resource-group.tf

AWS Resource Group을 생성하여 모듈이 만든 리소스를 그룹화합니다. 모든 모듈에서 동일한 패턴을 사용합니다:

```hcl
module "resource_group" {
  source  = "tedilabs/misc/aws//modules/resource-group"
  version = "~> 0.12.0"

  count = (var.resource_group.enabled && var.module_tags_enabled) ? 1 : 0
  # ...
}
```

### migrations.tf (선택)

`moved` 블록을 사용하여 state migration을 관리합니다. 날짜 주석으로 마이그레이션 시점을 기록합니다:

```hcl
# 2023-02-01
moved {
  from = aws_resourcegroups_group.this[0]
  to   = module.resource_group[0].aws_resourcegroups_group.this
}
```

## 코딩 컨벤션

### 리소스 네이밍

- 주 리소스: `aws_<type> "this"` (예: `aws_vpc "this"`, `aws_eks_cluster "this"`)
- 관련 리소스: full type + 설명적 이름 (예: `aws_vpc_ipv4_cidr_block_association "this"`)
- 내부 모듈 참조 시 더블 언더스코어로 용도 구분: `module.security_group__control_plane`

### 식별자 네이밍

- 모든 식별자는 `snake_case` 사용
- `extended_snake_case` 허용 (더블 언더스코어 `__` 포함 가능, 예: `security_group__node`)
- tflint `terraform_naming_convention` 규칙으로 강제

### 태그 패턴

모든 리소스에 일관된 태그 병합 패턴을 적용합니다:

```hcl
tags = merge(
  {
    "Name" = local.metadata.name
  },
  local.module_tags,
  var.tags,
)
```

- `Name` 태그는 항상 첫 번째
- `local.module_tags`는 모듈 메타데이터 태그 (`module.terraform.io/*`)
- `var.tags`는 사용자 정의 태그로 최종 병합 (덮어쓰기 가능)
- 후행 쉼표(trailing comma) 항상 포함

### 조건부 리소스 생성

```hcl
# count 기반 (단일 리소스)
count = var.internet_gateway.enabled ? 1 : 0

# for_each 기반 (컬렉션)
for_each = {
  for listener in var.listeners :
  listener.port => listener
}

# dynamic 블록 (선택적 중첩 구성)
dynamic "outpost_config" {
  for_each = var.outpost_config != null ? [var.outpost_config] : []
  content { ... }
}
```

### 안전한 접근 패턴

```hcl
# count로 생성된 리소스의 안전한 접근
one(aws_internet_gateway.this[*].id)

# 중첩 속성의 안전한 접근
try(aws_eks_cluster.this.compute_config[0].enabled, false)
```

### 변수 검증 패턴

```hcl
# Enum 검증
validation {
  condition     = contains(["MANUAL", "IPAM_POOL"], var.type)
  error_message = "Valid values for `type` are `MANUAL` and `IPAM_POOL`."
}

# 컬렉션 내 전체 항목 검증
validation {
  condition = alltrue([
    for item in var.items :
    contains(["A", "B"], item.type)
  ])
  error_message = "Valid values..."
}

# 범위 검증
validation {
  condition = anytrue([
    var.asn >= 64512 && var.asn <= 65534,
    var.asn >= 4200000000 && var.asn <= 4294967294,
  ])
  error_message = "Value must be in range..."
}
```

### 모듈 간 참조

- 형제 모듈 참조: `source = "../<sibling-module>"`
- 하위 모듈 호출 시 `resource_group.enabled = false`, `module_tags_enabled = false` 설정하여 중복 방지
- 외부 모듈 참조: Terraform Registry 소스 사용 (예: `tedilabs/misc/aws//modules/resource-group`)

### 주석 패턴

```hcl
###################################################
# Section Title
###################################################

# INFO: Not supported attributes
# - `attribute_name`

# TODO: 추후 구현 예정 사항
```

- 섹션 구분자: `#` 49개로 구성된 라인
- 미지원 속성: `# INFO: Not supported attributes` 주석
- 주석이 달린 코드 블록은 향후 지원 예정 기능을 나타냄

## 포맷팅 및 린팅

### EditorConfig

- 인코딩: UTF-8
- 줄바꿈: LF (Unix)
- 들여쓰기: 스페이스 2칸 (모든 파일)
- 후행 공백 제거, 파일 끝 개행 삽입

### Terraform fmt

`terraform fmt`로 HCL 코드를 포맷팅합니다. pre-commit 훅으로 자동 실행됩니다.

### tflint

`.tflint.hcl` 설정 파일로 규칙을 관리합니다:

- **terraform 플러그인**: `recommended` 프리셋 + 추가 규칙
  - `terraform_comment_syntax`: 주석 문법 검사
  - `terraform_documented_variables`: 변수 description 필수
  - `terraform_documented_outputs`: 출력 description 필수
  - `terraform_naming_convention`: `snake_case` / `extended_snake_case` 강제
  - `terraform_unused_required_providers`: 미사용 프로바이더 검출
- **aws 플러그인** (`tflint-ruleset-aws` v0.44.0):
  - `aws_iam_policy_attachment_exclusive_attachment`
  - `aws_iam_role_deprecated_policy_attributes`
  - `aws_security_group_inline_rules`
  - `aws_security_group_rule_deprecated`

### terraform-docs

`terraform-docs`로 각 모듈의 `README.md`를 자동 생성합니다. `--sort-by required` 옵션으로 필수 변수를 먼저 정렬합니다.

## 커밋 & CI/CD

### 커밋 메시지

[Conventional Commits](https://www.conventionalcommits.org/) 규칙을 따릅니다. `conventional-pre-commit` 훅으로 commit-msg 단계에서 검증합니다.

```
<type>: <description>

[optional body]
```

유효한 type: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`

### Pre-commit Hooks

`.pre-commit-config.yaml`에 정의된 훅:

1. `terraform_fmt` — `terraform fmt --diff`
2. `terraform_validate` — `terraform validate` (retry-once-with-cleanup, tf-init-args=-upgrade)
3. `terraform_tflint` — tflint 검사 (`modules/` 디렉토리만)
4. `terraform_docs` — README.md 자동 생성
5. `trailing-whitespace` — 후행 공백 제거
6. `yamllint` — YAML 문법 검사
7. `conventional-pre-commit` — 커밋 메시지 규칙 검증

### GitHub Actions CI

`terraform.integration.yaml` 워크플로우:
- `modules/`와 `examples/` 하위의 변경 파일을 감지하여 영향받는 디렉토리만 검사
- `terraform validate`와 `tflint`를 매트릭스로 병렬 실행
- PR과 main 브랜치 push 시 트리거

## 레포지토리별 도메인 매핑

| 레포지토리 | AWS 서비스 도메인 | 주요 모듈 |
|---|---|---|
| `terraform-aws-account` | IAM, Account | account, iam-role, iam-policy, iam-user, region |
| `terraform-aws-api-gateway` | API Gateway | (개발 중) |
| `terraform-aws-cert` | ACM | amazon-issued-cert, imported-cert, private-ca-issued-cert |
| `terraform-aws-cloudfront` | CloudFront | distribution, cache-policy, origin-access-control |
| `terraform-aws-container` | ECS/EKS/ECR | eks-cluster, eks-node-group, ecr-repository |
| `terraform-aws-cost` | Cost Management | cur-report, rds-reserved-instance |
| `terraform-aws-data` | S3, Glue, Athena, Lake Formation | s3-bucket, glue-database, athena-workgroup |
| `terraform-aws-db` | ElastiCache | elasticache-redis-cluster, elasticache-redis-user |
| `terraform-aws-domain` | Route 53 | public-zone, private-zone, record-set, registered-domain |
| `terraform-aws-ec2` | EC2 | instance, placement-group, ssh-key |
| `terraform-aws-firewall` | WAF, DNS Firewall, FMS | waf-web-acl, dns-firewall, fms-dns-firewall-policy |
| `terraform-aws-ipam` | IPAM, Elastic IP, Prefix List | ipam, elastic-ip, managed-prefix-list |
| `terraform-aws-lambda` | Lambda, Step Functions | sfn-state-machine |
| `terraform-aws-load-balancer` | ELB | alb, nlb, gwlb + target-group, listener 모듈 |
| `terraform-aws-messaging` | EventBridge, MSK, SES, SNS | eventbridge-event-bus, msk-cluster, sns-standard-topic |
| `terraform-aws-misc` | 기타 | resource-group, s3-archive-bucket |
| `terraform-aws-ml` | ML | (개발 중) |
| `terraform-aws-network` | VPC | vpc, subnet-group, route-table, security-group, nacl |
| `terraform-aws-observability` | CloudWatch | cloudwatch-log-group, cloudwatch-oam-link |
| `terraform-aws-organization` | Organizations, RAM, SSO | organization, organizational-unit, sso-permission-set |
| `terraform-aws-quicksight` | QuickSight | account, data-set, data-source, folder |
| `terraform-aws-secret` | KMS, Secrets Manager, SSM | kms-key, secrets-manager-secret, ssm-parameter-store-parameter |
| `terraform-aws-security` | Security Hub, CloudTrail, Config, Macie | access-analyzer, cloudtrail-trail, config-recorder |
| `terraform-aws-transit-gateway` | Transit Gateway | transit-gateway, peering-attachment, route-table |
| `terraform-aws-vpc-connectivity` | VPC Lattice, Direct Connect, Reachability Analyzer | lattice-service, dx-gateway, reachability-analyzer-path |
| `terraform-aws-vpc-peering` | VPC Peering | peering, requester, accepter |
| `terraform-aws-vpc-privatelink` | PrivateLink | endpoint-service, interface-endpoint, gateway-endpoint |
| `terraform-aws-vpn` | VPN | customer-gateway, vpn-connection |
| `terraform-aws-wan` | Cloud WAN | global-network, site |

## 새 모듈 작성 가이드

1. `modules/<module-name>/` 디렉토리 생성
2. 필수 파일 작성: `main.tf`, `variables.tf`, `outputs.tf`, `versions.tf`, `resource-group.tf`
3. `main.tf` 상단에 `metadata` + `module_tags` locals 블록 추가 (패키지명은 해당 레포명)
4. 공통 변수 (`name`, `tags`, `module_tags_enabled`, `resource_group`) 포함
5. 주 리소스는 `"this"` 이름 사용
6. 태그 병합 패턴 적용 (`Name` + `module_tags` + `tags`)
7. `versions.tf`에 Terraform 및 프로바이더 최소 버전 지정
8. `terraform fmt`로 포맷팅 확인
9. 필요 시 `examples/` 디렉토리에 예제 추가
10. `VERSION` 파일 업데이트 (시맨틱 버전)
