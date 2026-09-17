# Research skills for Codex

This repository tracks three upstream research skill bundles for reuse with Codex:

- [scientific-agent-skills](https://github.com/K-Dense-AI/scientific-agent-skills) at `330c8e764435a731eff571e3efdda70b363d0792`
- [nature-skills](https://github.com/Yuan1z0825/nature-skills) at `2375e0abdf42158ef149256f2c64b1f759a0d274`
- [academic-research-skills-codex](https://github.com/Imbad0202/academic-research-skills-codex) at `3c37ef8ab480ba1e9370309c24b99977ad44091f`

The upstream repositories remain the source of truth. Use `scripts/install-research-skills.ps1` to clone the pinned revisions and copy their Codex-compatible skill directories into `$env:USERPROFILE\\.codex\\skills`.

The three router skills under `skills/` are installed locally as lightweight entry points and direct future work to the pinned upstream bundles.