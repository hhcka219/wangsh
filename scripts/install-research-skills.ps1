$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$vendor = Join-Path $root "vendor"
$destination = Join-Path $env:USERPROFILE ".codex\\skills"
New-Item -ItemType Directory -Force -Path $vendor, $destination | Out-Null

$bundles = @(
  @{ Name = "scientific-agent-skills"; Url = "https://github.com/K-Dense-AI/scientific-agent-skills.git"; Commit = "330c8e764435a731eff571e3efdda70b363d0792"; SkillRoot = "skills" },
  @{ Name = "nature-skills"; Url = "https://github.com/Yuan1z0825/nature-skills.git"; Commit = "2375e0abdf42158ef149256f2c64b1f759a0d274"; SkillRoot = "skills" },
  @{ Name = "academic-research-skills-codex"; Url = "https://github.com/Imbad0202/academic-research-skills-codex.git"; Commit = "3c37ef8ab480ba1e9370309c24b99977ad44091f"; SkillRoot = "skills/academic-research-suite" }
)

foreach ($bundle in $bundles) {
  $checkout = Join-Path $vendor $bundle.Name
  if (-not (Test-Path (Join-Path $checkout ".git"))) {
    git clone $bundle.Url $checkout
  }
  git -C $checkout fetch --depth 1 origin $bundle.Commit
  git -C $checkout checkout --detach $bundle.Commit

  $source = Join-Path $checkout $bundle.SkillRoot
  if (-not (Test-Path $source)) {
    throw "Skill source not found: $source"
  }

  if ($bundle.Name -eq "academic-research-skills-codex") {
    $target = Join-Path $destination "academic-research-suite"
    if (Test-Path $target) { Remove-Item -LiteralPath $target -Recurse -Force }
    Copy-Item -LiteralPath $source -Destination $target -Recurse
  } else {
    Get-ChildItem -LiteralPath $source -Directory | ForEach-Object {
      $target = Join-Path $destination $_.Name
      if (Test-Path $target) { Remove-Item -LiteralPath $target -Recurse -Force }
      Copy-Item -LiteralPath $_.FullName -Destination $target -Recurse
    }
  }
}

Write-Output "Installed pinned research skills into $destination"
