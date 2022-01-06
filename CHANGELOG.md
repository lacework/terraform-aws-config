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
