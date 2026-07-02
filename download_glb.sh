#!/bin/bash
# 대통령기록관 3D 유물 GLB 다운로드 스크립트
# 사용법: bash download_glb.sh

mkdir -p glb
echo "GLB 66건 다운로드 시작..."

MODELS=(
  "PAD0000023" "PAD0000026" "PAD0000028"
  "PED0000022" "PED0000051" "PED0000056"
  "PEE0000011" "PEE0000018" "PEE0000033" "PEE0000036"
  "PEE0000041" "PEE0000042" "PEE0000043" "PEE0000044"
  "PEE0000045" "PEE0000050" "PEE0000069" "PEE0000103"
  "PEE0000115" "PEE0000116" "PEE0000118" "PEE0000119"
  "PFE0000012" "PFE0000016"
  "PHE0000007" "PHE0000030" "PHE0000098" "PHE0000105"
  "PHE0000132" "PHE0000136" "PHE0000145"
  "PIE0000070" "PIE0000089" "PIE0000093"
  "PJE0000019" "PJE0000087" "PJE0000166" "PJE0000167"
  "PJE0000196" "PJE0000230" "PJE0000234" "PJE0000254"
  "PJE0000260" "PJE0000319" "PJE0000342" "PJE0000416"
  "PJE0000490" "PJE0000684"
  "PKE0000091" "PKE0000109" "PKE0000391"
  "PLE0000212" "PLE0000432" "PLE0000439"
  "PNE0000111" "PNE0000118" "PNE0000119" "PNE0000120" "PNE0000463"
  "POE0000162" "POE0000163" "POE0000349"
  "PQE0000479" "PQE0000808" "PQE0000811"
)

TOTAL=${#MODELS[@]}
COUNT=0

for MODEL in "${MODELS[@]}"; do
  COUNT=$((COUNT + 1))
  FILE="glb/${MODEL}.glb"
  URL="https://www.pa.go.kr/files/giftgallery/PA_3D/${MODEL}.glb"

  if [ -f "$FILE" ] && [ $(stat -f%z "$FILE" 2>/dev/null || stat -c%s "$FILE" 2>/dev/null) -gt 100000 ]; then
    echo "[${COUNT}/${TOTAL}] ${MODEL}: 이미 존재, 건너뜀"
    continue
  fi

  echo "[${COUNT}/${TOTAL}] ${MODEL} 다운로드 중..."
  curl -s -A "Mozilla/5.0" --max-time 60 -o "$FILE" "$URL"
  
  SIZE=$(stat -f%z "$FILE" 2>/dev/null || stat -c%s "$FILE" 2>/dev/null || echo 0)
  MB=$((SIZE / 1024 / 1024))
  echo "  → ${MB}MB 완료"
  sleep 0.3
done

echo ""
echo "완료! glb/ 폴더에 ${TOTAL}개 파일이 있습니다."
echo "이제 index.html, catalog.json, README.md와 함께 GitHub에 올리세요."
