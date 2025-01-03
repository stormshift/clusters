#!/usr/bin/env bash

# set -euo pipefail
# set -x
PR_FOLDER=$1
MAIN_FOLDER=$2

kustomize_folders=(
  "configuration/overlays/isar"
#  "configuration/overlays/coe-cluster"
  "configuration/overlays/stormshift-ocp1"
#  "configuration/overlays/stormshift-ocp2"
#  "configuration/overlays/stormshift-ocp3"
  "configuration/overlays/stormshift-ocp4"
  "configuration/overlays/stormshift-ocp5"
#  "configuration/overlays/stormshift-ocp6"
#  "configuration/overlays/stormshift-ocp7"
#  "configuration/overlays/stormshift-ocp8"
#  "configuration/overlays/stormshift-rhacm"
)

declare -a kustomize_folders_with_changes

echo -e "# Diff overview \n\n" > /tmp/diff-overview.md

echo -e "|Environment|Amount of diff lines|" >> /tmp/diff-overview.md
echo -e "|---|---|" >> /tmp/diff-overview.md


for folder in ${kustomize_folders[@]}; do

  env_name=$(basename $folder)
  echo "Let's check $folder"

  kustomize build \
    ${PR_FOLDER}/$folder \
    > /tmp/${env_name}.pr.yaml

  kustomize build \
    ${MAIN_FOLDER}/$folder \
    > /tmp/${env_name}.main.yaml

  diff -Nuar \
    /tmp/${env_name}.main.yaml \
    /tmp/${env_name}.pr.yaml \
    > /tmp/${env_name}.diff

  echo "Created /tmp/${env_name}.diff"
  amount_of_diff_lines=$(cat /tmp/${env_name}.diff | wc -l)
  if  [ "$amount_of_diff_lines" -gt "0" ]; then
    kustomize_folders_with_changes+=($folder)
  fi
  echo -e "|\`$folder\`| $amount_of_diff_lines" >> /tmp/diff-overview.md
done;


for folder in ${kustomize_folders_with_changes[@]}; do
  env_name=$(basename $folder)
  echo "Dump diff $folder ($env_name)";
  echo -e "\n\n" >> /tmp/diff-overview.md
  echo "<details>" >> /tmp/diff-overview.md
  echo -e "<summary>Diff $folder</summary>\n\n" >> /tmp/diff-overview.md
  echo '```diff' >> /tmp/diff-overview.md
  cat /tmp/${env_name}.diff  >> /tmp/diff-overview.md
  echo '```' >> /tmp/diff-overview.md
  echo '</details>' >> /tmp/diff-overview.md
  echo -e "\n\n" >> /tmp/diff-overview.md

done;
