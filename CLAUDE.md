# CLAUDE.md

이 문서는 `tedilabs/terraform-aws-*` 레포지토리들에 대한 공통 개발 가이드입니다.

## 프로젝트 개요

Tedilabs의 Terraform AWS 모듈 컬렉션으로, 각 레포지토리는 특정 AWS 서비스 도메인을 다루는 재사용 가능한 Terraform 모듈 패키지입니다. Apache License 2.0 하에 배포됩니다.

## 레포지토리 구조

```
terraform-aws-<service>/
├── .github/                    # GitHub 설정 (workflows, labeler, dependabot 등)
├── modules/                    # 기능 모듈들
│   └── <module-name>/
│       ├── main.tf             # 주요 리소스 정의
│       ├── variables.tf        # 입력 변수
│       ├── outputs.tf          # 출력값
│       ├── versions.tf         # Terraform/프로바이더 버전 제약
│       ├── resource-group.tf   # AWS Resource Group 설정
│       ├── migrations.tf       # moved {} 블록 (필요 시)
│       ├── README.md           # terraform-docs로 자동 생성
│       └── <feature>.tf        # 기능별 분리 (iam.tf, security-groups.tf 등)
├── examples/                   # 사용 예제 (모듈별 1개)
├── .pre-commit-config.yaml     # Pre-commit 훅 설정
├── .tflint.hcl                 # TFLint 린터 설정
├── .editorconfig               # 에디터 설정
├── .yamllint.yaml              # YAML 린팅 설정
├── README.md                   # 패키지 문서
├── VERSION                     # 시맨틱 버전 (예: "0.27.3")
└── LICENSE                     # Apache License 2.0
```

## 명령어

- **포맷팅**: `terraform fmt -diff` (pre-commit 훅으로 자동 실행)
- **검증**: `terraform validate` (pre-commit 훅으로 자동 실행, `--retry-once-with-cleanup=true`)
- **린팅**: `tflint --config=.tflint.hcl` (modules/ 디렉토리 대상)
- **문서 생성**: `terraform-docs` (pre-commit 훅으로 자동 실행, `--sort-by required`)
- **YAML 린팅**: `yamllint` (.yamllint.yaml 설정 사용)
- **전체 pre-commit 실행**: `pre-commit run --all-files`

## 코딩 컨벤션

### 네이밍

- **모듈 디렉토리**: 소문자 하이픈 (예: `eks-cluster`, `nat-gateway`, `alb-ip-target-group`)
- **Terraform 식별자**: `extended_snake_case` — 소문자 스네이크 케이스에 이중 밑줄(`__`) 허용
  - 정규식: `^[a-z][a-z0-9]+([_]{1,2}[a-z0-9]+)*$`
  - 이중 밑줄은 동일 타입의 병렬 리소스 구분에 사용 (예: `security_group__control_plane`, `role__node`)
- **리소스 참조**: 단일 리소스는 항상 `.this` 사용 (예: `aws_vpc.this`, `aws_eks_cluster.this`)
- **변수명**: snake_case, boolean은 `_enabled`/`_required` 접미사 사용 (예: `deletion_protection_enabled`)
- **Locals**: `metadata`, `module_tags`는 표준 패턴, 계산 로직에 활용

### 변수 (variables.tf)

- 설명은 반드시 `(Required)` 또는 `(Optional)`로 시작
- `nullable` 속성 명시적 지정 (`false`가 일반적, `null` 허용 시 `true`)
- 복잡한 타입은 `object()`에 `optional()` 활용
- 유효성 검증은 `validation {}` 블록으로 수행 (`contains()`, `alltrue()`, `anytrue()` 등)
- 복잡한 설명은 `<<EOF ... EOF` heredoc 형식 사용

```hcl
variable "name" {
  description = "(Required) Desired name for the resource."
  type        = string
  nullable    = false
}

variable "feature" {
  description = "(Optional) A configuration for the feature. Defaults to `{}`."
  type = object({
    enabled = optional(bool, false)
    value   = optional(string, "DEFAULT")
  })
  default  = {}
  nullable = false
}
```

### 표준 변수 (모든 모듈 공통)

1. `region` — `(Optional)`, `type = string`, `default = null`, `nullable = true`
2. `name` — `(Required)`, `type = string`, `nullable = false`
3. `tags` — `(Optional)`, `type = map(string)`, `default = {}`
4. `module_tags_enabled` — `(Optional)`, `type = bool`, `default = true`
5. `resource_group` — `(Optional)`, `type = object({enabled, name, description})`, `default = {}`

### 출력값 (outputs.tf)

- 기본 출력: `id`, `arn`, `name`, `region` (해당 시)
- 설명은 간결한 문장형
- `resource_group` 출력은 모든 모듈에서 표준 패턴 사용

### main.tf 표준 패턴

모든 모듈의 `main.tf`는 다음 `locals` 블록으로 시작:

```hcl
locals {
  metadata = {
    package = "terraform-aws-<service>"
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

### 태그

리소스의 `tags` 속성은 항상 다음 순서로 병합:

```hcl
tags = merge(
  {
    "Name" = local.metadata.name
  },
  local.module_tags,
  var.tags,
)
```

### 코드 섹션 구분

```hcl
###################################################
# 섹션 제목
###################################################
```

### 인라인 주석

- `# INFO:` — 구현 참고 사항
- `# TODO:` — 향후 개선 사항
- `# Note:` — 중요한 구현 세부사항

### 버전 제약 (versions.tf)

- Terraform: `>= 1.6` ~ `>= 1.12` (모듈에 따라 다름)
- AWS 프로바이더: `>= 4.61` ~ `>= 6.15` (모듈에 따라 다름)
- 예제에서는 `~>` 연산자 사용 (예: `~> 1.12`, `~> 6.0`)

### Resource Group 통합

모든 모듈은 `resource-group.tf`에서 `tedilabs/misc/aws//modules/resource-group`을 서브모듈로 호출합니다:

```hcl
module "resource_group" {
  source  = "tedilabs/misc/aws//modules/resource-group"
  version = "~> 0.12.0"

  count = (var.resource_group.enabled && var.module_tags_enabled) ? 1 : 0
  # ...
}
```

### 마이그레이션 (migrations.tf)

리팩토링 시 `moved {}` 블록을 사용하며, 날짜와 설명을 주석으로 기록:

```hcl
# 2025-11-17: Make OIDC provider for IRSA to be optional
moved {
  from = module.oidc_provider.aws_iam_openid_connect_provider.this
  to   = module.oidc_provider[0].aws_iam_openid_connect_provider.this
}
```

### 패턴 사용 지침

- **`for_each`** — 리소스 반복 시 기본 패턴, dict comprehension과 함께 사용
- **`count`** — 선택적 리소스 생성에만 사용 (예: `count = var.enabled ? 1 : 0`)
- **`dynamic` 블록** — 조건부 중첩 속성에 활용
- **입력 유효성 검증** — `validation {}` 블록으로 사전 검증 (precondition/postcondition보다 우선)

## 커밋 메시지 컨벤션

[Conventional Commits](https://www.conventionalcommits.org/) 형식을 따르며, pre-commit 훅으로 검증됩니다:

```
<type>(<scope>): <description>

# 예시:
feat(eks-cluster): support zonal shift configuration
fix(vpc): make from_port and to_port optional
chore: update copyright year to 2026
chore: bump to v0.27.3
```

- **type**: `feat`, `fix`, `chore`, `docs` 등
- **scope**: 모듈 이름 (선택사항, 예: `eks-cluster`, `vpc`, `s3-bucket`)
- **description**: 명령형 현재 시제, 소문자 시작

## README 문서

- 모듈의 `README.md`는 `terraform-docs`로 자동 생성됩니다
- `<!-- BEGIN_TF_DOCS -->` ~ `<!-- END_TF_DOCS -->` 마커 사이에 자동 업데이트
- README를 직접 수정하지 말고, 소스 코드(변수 설명, 출력값 설명)를 수정하세요

## 린팅 규칙

### TFLint (.tflint.hcl)

- `terraform` 플러그인: `recommended` 프리셋
- `aws` 플러그인 (v0.44.0): deep_check 비활성화
- 네이밍: `extended_snake_case` 강제 (모든 식별자)
- 모든 변수와 출력값에 description 필수
- 사용하지 않는 required_providers 금지

### Pre-commit 훅

1. `terraform_fmt` — Terraform 파일 포맷팅
2. `terraform_validate` — Terraform 검증
3. `terraform_tflint` — TFLint 린팅 (modules/ 대상)
4. `terraform_docs` — 문서 자동 생성
5. `trailing-whitespace` — 후행 공백 제거
6. `yamllint` — YAML 파일 린팅
7. `conventional-pre-commit` — 커밋 메시지 검증

## 에디터 설정

- 문자셋: UTF-8
- 줄바꿈: LF
- 들여쓰기: 스페이스 2칸 (모든 파일)
- 후행 공백 제거
- 파일 끝 빈 줄 삽입
