#!/usr/bin/env bash
# ==============================================================================
# CYBERNEST HOLDINGS LLC // CYBERNEST LABS
# STATIC ARCHIVE INDEX & SHA-256 CHECKSUM SYNCHRONIZER
# ==============================================================================
set -euo pipefail
IFS=$'\n\t'
umask 022

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZIP_INDEX_DIR="${ROOT_DIR}/Context/ProjDocs/SoftwareZips"

mkdir -p "${ZIP_INDEX_DIR}"

echo "[INFO] Synchronizing CyberNest Labs codebase archives into Context/ProjDocs/SoftwareZips/..."

# Pass --pull-github to fetch fresh archives directly from GitHub repositories
if [[ "${1:-}" == "--pull-github" ]]; then
  echo "[INFO] Pulling fresh archive zipballs directly from GitHub..."
  TOKEN="$(gh auth token 2>/dev/null || echo "")"
  declare -A GITHUB_REPOS=(
    ["BlackRouteWebPublic-main.zip"]="BlackRouteWebPublic"
    ["KwikLogPro-main.zip"]="KwikLogPro"
    ["NestComm-main.zip"]="NestComm"
    ["NestLink-main.zip"]="NestLink"
    ["NestPatch-main.zip"]="NestPatch"
    ["NestSBOM-main.zip"]="NestSBOM"
  )
  for dest_name in "${!GITHUB_REPOS[@]}"; do
    rname="${GITHUB_REPOS[$dest_name]}"
    echo "  Downloading ${rname}..."
    if [[ -n "$TOKEN" ]]; then
      curl -s -L -H "Authorization: Bearer $TOKEN" "https://github.com/auxk0rd03/${rname}/archive/refs/heads/main.zip" -o "${ZIP_INDEX_DIR}/${dest_name}"
    else
      curl -s -L "https://github.com/auxk0rd03/${rname}/archive/refs/heads/main.zip" -o "${ZIP_INDEX_DIR}/${dest_name}"
    fi
  done
fi

declare -A SOURCE_ZIPS=(
  ["BlackRouteWebPublic-main.zip"]="Context/ProjDocs/BlackRouteWeb/BlackRouteWebPublic-main.zip"
  ["KwikLogPro-main.zip"]="Context/ProjDocs/KwikLogPro/KwikLogPro-main.zip"
  ["NestComm-main.zip"]="Context/ProjDocs/NestComm/NestComm-main.zip"
  ["NestLink-main.zip"]="Context/ProjDocs/NestLink/NestLink-main.zip"
  ["NestPatch-main.zip"]="Context/ProjDocs/NestPatch/NestPatch-main.zip"
  ["NestSBOM-main.zip"]="Context/ProjDocs/NestSBOM/NestSBOM-main.zip"
)

for dest_name in "${!SOURCE_ZIPS[@]}"; do
  src_rel="${SOURCE_ZIPS[$dest_name]}"
  if [[ -f "${ROOT_DIR}/${src_rel}" ]]; then
    cp -f "${ROOT_DIR}/${src_rel}" "${ZIP_INDEX_DIR}/${dest_name}"
  fi
done

echo "[INFO] Generating SHA256SUMS.txt in ${ZIP_INDEX_DIR}..."
(
  cd "${ZIP_INDEX_DIR}"
  sha256sum *.zip > SHA256SUMS.txt
)

echo "--------------------------------------------------------------------------------"
printf "%-30s | %-12s | %s\n" "ARCHIVE FILENAME" "SIZE (BYTES)" "SHA-256 DIGEST"
echo "--------------------------------------------------------------------------------"
for zfile in "${ZIP_INDEX_DIR}"/*.zip; do
  fname="$(basename "${zfile}")"
  fsize="$(stat -c%s "${zfile}")"
  fhash="$(sha256sum "${zfile}" | awk '{print $1}')"
  printf "%-30s | %-12s | %s\n" "${fname}" "${fsize}" "${fhash}"
done
echo "--------------------------------------------------------------------------------"
echo "[OK] Archive index synchronization complete. Verify SHA256SUMS.txt prior to git commit."
