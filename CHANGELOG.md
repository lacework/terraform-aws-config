# v0.14.2

## Bug Fixes
* fix(LINK-2638): Add permission for efs ListTagsForResource (#93) (jingjingzhang-lw)([c5cf5c8](https://github.com/lacework/terraform-aws-config/commit/c5cf5c8adc7d91712de34aa28e9737c7a13af302))

## Other Changes
* ci: version bump to v0.14.2-dev (Lacework)([2f60c59](https://github.com/lacework/terraform-aws-config/commit/2f60c591bed6e56748990e62dd05c636ea86cb0c))
---
# v0.14.1

## Other Changes
* chore: set local var module name (#91) (Darren)([d3e3698](https://github.com/lacework/terraform-aws-config/commit/d3e3698105ec085a0632cb7397bec5066a831c31))
* ci: version bump to v0.14.1-dev (Lacework)([430868e](https://github.com/lacework/terraform-aws-config/commit/430868ead4231ecc8f745a2b66b3c4b6a1e529b9))
---
# v0.14.0

## Features
* feat(RAIN-91433): Add permission for get-api-keys in apigateway and apigatewayv2 (#87) (jingjingzhang-lw)([6e4c28f](https://github.com/lacework/terraform-aws-config/commit/6e4c28fcd5ea1449cabc291143d0e6337ad66d98))
* feat(RAIN-90870): Add permission for five waf-regional APIs (#83) (jingjingzhang-lw)([b868fe3](https://github.com/lacework/terraform-aws-config/commit/b868fe33b762305c0407be223922f592349f0d3f))
* feat(RAIN-90851): Add permission for two glue APIs (#84) (jingjingzhang-lw)([601e098](https://github.com/lacework/terraform-aws-config/commit/601e098bb74a5cb69315ecd29dae9d83dd19230e))
## Documentation Updates
* docs(readme): add terraform docs automation (#81) (Timothy MacDonald)([4cc956f](https://github.com/lacework/terraform-aws-config/commit/4cc956f0a24b0444e8326eb12f4cc22a0a475dd9))
## Other Changes
* chore: add lacework_metric_module datasource (#89) (Darren)([94ca682](https://github.com/lacework/terraform-aws-config/commit/94ca682158f6b5cf5988c2cd6e0a0d013859aba2))
* chore: update `time` provider to `~> 0.7` (#80) (Spencer Williams)([e947030](https://github.com/lacework/terraform-aws-config/commit/e947030435a0a80136193a0bdc5b0acfa73d9491))
* chore: update CHANGELOG with ad-hoc releases (#79) (Salim Afiune)([1392126](https://github.com/lacework/terraform-aws-config/commit/1392126b6b0c7b1821008ae6e3bdc8e6177c7ccc))
* ci: version bump to v0.13.1-dev (Lacework)([94041b2](https://github.com/lacework/terraform-aws-config/commit/94041b2a8f468ae4400283dcac9c31398cc86fcf))
---
# v0.13.0

## Features
* feat: enforce External ID v2 format via iam-role module (#76) (djmctavish)([ce9b91e](https://github.com/lacework/terraform-aws-config/commit/ce9b91e08699d6ea7b8d605230cdd2dbbc8e043c))
## Other Changes
* ci: version bump to v0.12.1-dev (Lacework)([de3fd4d](https://github.com/lacework/terraform-aws-config/commit/de3fd4dc2e80ac8a7166030f584466ff6b54fd85))
---
# v0.12.0

## Features
* feat: Add Apigatewayv2 related permissions (#71) (ramgudivada-lacework)([a615061](https://github.com/lacework/terraform-aws-config/commit/a61506128d66c0724547f4f3edf1a83ca2502c5e))
* feat: Add Apigateway related permissions (#70) (ramgudivada-lacework)([4306ac8](https://github.com/lacework/terraform-aws-config/commit/4306ac80436f03a3799f48641e14eed2b96e02db))
* feat: Add ReadOnly access to SSO APIs (#69) (Teddy Reed)([fc891e2](https://github.com/lacework/terraform-aws-config/commit/fc891e25d43ca741f9acd02b697ef24e595bb95e))
* feat: Add ReadOnly access to IdentityStore APIs (#68) (Teddy Reed)([ae70a06](https://github.com/lacework/terraform-aws-config/commit/ae70a06e76a9c1c9adf47fcea90a010ede2b1ea1))
## Other Changes
* ci: version bump to v0.11.1-dev (Lacework)([df9969c](https://github.com/lacework/terraform-aws-config/commit/df9969c8144d981d2a71381b1b08123e4b329edd))
---
# v0.11.0

## Features
* feat: Add support for AWS provider 5.0 (#65) (Maksym Vlasov)([64966a2](https://github.com/lacework/terraform-aws-config/commit/64966a28081cd3007eaf95ca859e87b4e511e1cf))
* feat: Add support for AWS provider 5.0 (#65) (Maksym Vlasov)([dd48f47](https://github.com/lacework/terraform-aws-config/commit/dd48f473c245b0337e6a4f80ce1fe7585fe3028c))
## Other Changes
* ci: version bump to v0.10.1-dev (Lacework)([db0e84c](https://github.com/lacework/terraform-aws-config/commit/db0e84c7d855646ef3fae216efae8f4030561625))
---
# v0.10.0

## Features
* feat: Add Sagemaker related permissions (#60) (ramgudivada-lacework)([3f7e1c9](https://github.com/lacework/terraform-aws-config/commit/3f7e1c917cd5058654f9570a37218074fcabf0b9))
* feat: EMR permissions (#59) (Darren)([32762e0](https://github.com/lacework/terraform-aws-config/commit/32762e0f79c8834b8f39a74ec6a086d8c153c8e7))
## Other Changes
* ci: tfsec (jon-stewart)([7b8deca](https://github.com/lacework/terraform-aws-config/commit/7b8deca542c1b9975c063399a8e241c747ac9fcb))
* ci: version bump to v0.9.1-dev (Lacework)([45fc0bb](https://github.com/lacework/terraform-aws-config/commit/45fc0bb93201b93346c92d25bb87238d732437b8))
---
# v0.9.0

## Features
* feat: audit policy readme (jon-stewart)([29f16d3](https://github.com/lacework/terraform-aws-config/commit/29f16d360f98b8a9c656df0e6eb3c96606faeec7))
* feat: EFS audit policy permissions (jon-stewart)([ab2e598](https://github.com/lacework/terraform-aws-config/commit/ab2e5988e1f2d0dba99928f6e0291f279f487f3e))
## Other Changes
* ci: version bump to v0.8.1-dev (Lacework)([dc0a216](https://github.com/lacework/terraform-aws-config/commit/dc0a2161ac7f1e53a23d30f844b3e4145fcbcbab))
---
# v0.8.0

## Features
* feat: add permissions_boundary variable (#52) (Victor Knell)([8a3d8d3](https://github.com/lacework/terraform-aws-config/commit/8a3d8d322fe1bfe42402a658e5aa0070f07819fb))
## Other Changes
* ci: version bump to v0.7.2-dev (Lacework)([6530ede](https://github.com/lacework/terraform-aws-config/commit/6530edecf5188f1cd38796845d5e48769d421b5a))
---
# v0.7.2

## Bug Fixes
* fix(pin): module iam-role/aws version ~> 0.3.0
* fix(revert): "docs: update Lacework provider version in readme (#50)"
* fix(revert): "chore: update Lacework provider version to v1 (#49)"
---
# v0.7.1

## Documentation Updates
* docs: update Lacework provider version in readme (#50) (Darren)([28e80ce](https://github.com/lacework/terraform-aws-config/commit/28e80ce0db2f0f8cb96b7c6b18cdb6623783592d))
## Other Changes
* chore: update Lacework provider version to v1 (#49) (Darren)([7558cc8](https://github.com/lacework/terraform-aws-config/commit/7558cc8cb391826dde45eaff1f3545f9dfdadddc))
* ci: version bump to v0.7.1-dev (Lacework)([ddd99e4](https://github.com/lacework/terraform-aws-config/commit/ddd99e4cf9ccd522c62bd1d3041f32801e38f279))
---
# v0.7.0

## Features
* feat: parameterize IAM policy attachment (#47) (Steve)([23fb300](https://github.com/lacework/terraform-aws-config/commit/23fb3001f931472c61f83e056b4cb08b77a95795))
## Bug Fixes
* fix: set lacework provider to minimum version for api v2 migration (#46) (Darren)([da744e3](https://github.com/lacework/terraform-aws-config/commit/da744e3e3181be69f60f53d695aed98b8b0dfaa6))
## Other Changes
* ci: version bump to v0.6.1-dev (Lacework)([9c4eb44](https://github.com/lacework/terraform-aws-config/commit/9c4eb4469bb1c25a3ebd400d37bcc4a5e23ae6c3))
---
# v0.6.0

## Features
* feat: deprecate support for Terraform 0.12 and 0.13 (#43) (Darren)([f3280c5](https://github.com/lacework/terraform-aws-config/commit/f3280c5387c4fbd7f23b9d36fbcc3e67c8b095bd))
## Documentation Updates
* docs: add example to configure multiple accounts (#44) (Salim Afiune)([762970f](https://github.com/lacework/terraform-aws-config/commit/762970f6b473eb22fa6fb1e20d75d1e27fc794f8))
## Other Changes
* ci: version bump to v0.5.1-dev (Lacework)([e928828](https://github.com/lacework/terraform-aws-config/commit/e9288281780a333ee138c5c081187f00fb30068b))
---
# v0.5.1

## Bug Fixes

* fix(pin): module iam-role/aws version ~> 0.2.0
---
# v0.5.0

## Features
* feat: support aws provider 4.x (#39) (naseemkullah)([2131806](https://github.com/lacework/terraform-aws-config/commit/2131806416f0417a45b43fe106b2e474c9bce6df))
## Other Changes
* chore: update PR template (#37) (Darren)([909e23a](https://github.com/lacework/terraform-aws-config/commit/909e23acf23a2c483b2254ec709d80e32cf490c1))
* ci: version bump to v0.4.2-dev (Lacework)([9fa033c](https://github.com/lacework/terraform-aws-config/commit/9fa033c349a646273f7c5713e4fefe8d9631468c))
---
# v0.4.1

## Bug Fixes
* fix: bump aws provider min version to 3.35 (#35) (Salim Afiune)([c120838](https://github.com/lacework/terraform-aws-config/commit/c120838e88ff09d70ee437c4055d68c0116ec100))
## Other Changes
* ci: version bump to v0.4.1-dev (Lacework)([e3fea29](https://github.com/lacework/terraform-aws-config/commit/e3fea297aaa0dfd2dd8cb1d0e4a922f9d56f9876))
---
# v0.4.0

## Features
* feat: add get-public-access-block permission (hazedav)([9827fb8](https://github.com/lacework/terraform-aws-config/commit/9827fb834aed8524d4dd81f11b536d2c1b864fa0))
## Other Changes
* ci: version bump to v0.3.2-dev (Lacework)([5e9b74e](https://github.com/lacework/terraform-aws-config/commit/5e9b74eaee945f85042d45c7e1a8904c0bd9ae99))
---
# v0.3.1

## Bug Fixes
* fix: add tags to IAM Policy (#30) (rajgandhi9)([ec108f3](https://github.com/lacework/terraform-aws-config/commit/ec108f3411e0b7eb6ff6547c47e3f575240fc89b))
## Documentation Updates
* docs: Add contributing documentation (#27) (Darren)([2fb0e69](https://github.com/lacework/terraform-aws-config/commit/2fb0e6981e4f9ad1ae3fbf15aaac0073de275a77))
## Other Changes
* ci: version bump to v0.3.1-dev (Lacework)([f928229](https://github.com/lacework/terraform-aws-config/commit/f928229087f6b00dd496b46ea9ab367126282e43))
---
# v0.3.0

## Features
* feat: add custom lacework audit policy (hazedav)([6c081dd](https://github.com/lacework/terraform-aws-config/commit/6c081dd5b3a568806fa4372352476db06d6e1ff8))
## Other Changes
* chore: version bump to v0.2.3-dev (Lacework)([60e7070](https://github.com/lacework/terraform-aws-config/commit/60e70709557b0be27c0f26d9eba1ce47aec68dda))
* ci: sign lacework-releng commits (#25) (Salim Afiune)([1ba3aa0](https://github.com/lacework/terraform-aws-config/commit/1ba3aa050f6b324dbd0d1abee3a52b038a470e82))
---
# v0.2.2

## Documentation Updates
* docs: standardized variable descriptions and formatting (Alan Nix)([17a2cda](https://github.com/lacework/terraform-aws-config/commit/17a2cda3a61b4d62824035e44d9a1009ddab4bc1))
* docs: updated example doc structure and version constraints (Alan Nix)([3abddff](https://github.com/lacework/terraform-aws-config/commit/3abddff93ee559adb8e9eb25c382eae36cce2584))
## Other Changes
* chore: updated .terraform entry in .gitignore to exclude lock files (Alan Nix)([e7aab4c](https://github.com/lacework/terraform-aws-config/commit/e7aab4c5e4473f1b8da3ff62f20a710a307b46cf))
* chore: version bump to v0.2.2-dev (Lacework)([4adb912](https://github.com/lacework/terraform-aws-config/commit/4adb912aea7a2fea7a20695301967c85182bb3ab))
---
# v0.2.1

## Other Changes
* chore: bump required version of TF to 0.12.31 (#21) (Scott Ford)([923dcd2](https://github.com/lacework/terraform-aws-config/commit/923dcd28a06fb6be529f9315372b3b76adc0ca72))
* ci: fix finding major versions during release (#20) (Salim Afiune)([bd9cd9e](https://github.com/lacework/terraform-aws-config/commit/bd9cd9ede1b51d40bad716a9391168931705b8b4))
* ci: switch PR test from CircleCI to CodeFresh (#18) (Darren)([8f2db09](https://github.com/lacework/terraform-aws-config/commit/8f2db09fa01d5187cfa5747ff94e138e5ce8e13e))
---
# v0.2.0

## Refactor
* refactor: make IAM role name unique (Salim Afiune Maya)([34c3a8d](https://github.com/lacework/terraform-aws-config/commit/34c3a8d2a21db86ef2dc18f20e88e368f628714f))
## Other Changes
* ci: switch releases to be own by Lacework releng ⚡ (Salim Afiune Maya)([9971559](https://github.com/lacework/terraform-aws-config/commit/997155978d06f6a52f3018945b06eb0fddb27d48))
---
# v0.1.4

## Documentation Updates
* docs: Update all example scenarios (#14) (Scott Ford)([20e5cdc](https://github.com/lacework/terraform-aws-config/commit/20e5cdcbeb60b4a34420dfffa96a44d49ffd36be))
## Other Changes
* ci: send slack notifications to team alias ⭐ (#13) (Salim Afiune)([d39eb08](https://github.com/lacework/terraform-aws-config/commit/d39eb0841cce66a8791ed5af93ede7e89a94963d))
---
# v0.1.3

## Features
* feat(tags): Added the ability to tag created resources (#7) (Alan Nix)([5bbfe07](https://github.com/lacework/terraform-aws-config/commit/5bbfe079227aede2a9b2848dadbcccde6dec4d12))
## Bug Fixes
* fix: readd removed lines in release script (#10) (Darren)([bbf5886](https://github.com/lacework/terraform-aws-config/commit/bbf588601f19b880a5c057bf0b4b02dc6d7bc9ce))
## Other Changes
* ci: new release.sh release notes generation  (#8) (Darren)([8a47efc](https://github.com/lacework/terraform-aws-config/commit/8a47efccd10c9734450e0b9e3bb20d759d5ce8db))
---
# v0.1.2

## Documentation Updates
* docs: update README badge (Salim Afiune Maya)([c88d432](https://github.com/lacework/terraform-aws-config/commit/c88d432f4da2866ae0f6708919124e38e2518990))
## Other Changes
* chore(version): pessimistic constraint for iam-role module (Salim Afiune Maya)([33ccb6e](https://github.com/lacework/terraform-aws-config/commit/33ccb6e0310cf4963a687206dbfa77d902abac50))
* chore(version): bump to aws 3.x provider (Salim Afiune Maya)([b257dc8](https://github.com/lacework/terraform-aws-config/commit/b257dc806df732442d468539e68848c25cce1a89))
* ci: rename the default branch to main (#4) (Salim Afiune)([28dfcd1](https://github.com/lacework/terraform-aws-config/commit/28dfcd1fa1a77e2eae4d6582bd3c4a3a19c00d72))
* ci: test on Terraform 13 (Salim Afiune Maya)([faeb007](https://github.com/lacework/terraform-aws-config/commit/faeb007a1573273e72619a0a619af440803589b1))
---
# v0.1.1

## Bug Fixes
* fix: pin lacework provider to the registry (Salim Afiune Maya)([97df6d8](https://github.com/lacework/terraform-aws-config/commit/97df6d8a3489d667d1f24715e594f552dd7948b8))
---
# v0.1.0

Initial commit
