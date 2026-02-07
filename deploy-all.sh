#!/bin/bash

# Deploy all Mintlify documentation sites
# Run from docs-main root directory

set -e  # Exit on error

PRODUCTS=("sgm-sparcc" "aicr-platform" "rally-stack" "towedge" "ps-edge" "sfp" "intelligentspm" "document-intelligence")

echo "🚀 Deploying all Blue Horizons Group documentation sites..."
echo ""

for product in "${PRODUCTS[@]}"; do
  echo "📦 Deploying $product..."

  if [ ! -d "docs/$product" ]; then
    echo "❌ Directory docs/$product not found"
    continue
  fi

  cd "docs/$product"

  if [ ! -f "mint.json" ]; then
    echo "❌ mint.json not found in docs/$product"
    cd ../..
    continue
  fi

  echo "   Validating configuration..."
  mintlify validate || echo "   ⚠️  Validation warnings"

  echo "   Deploying to Mintlify..."
  mintlify deploy

  cd ../..
  echo "✅ $product deployed successfully"
  echo ""
done

echo "🎉 All sites deployed!"
echo ""
echo "Verification URLs:"
echo "  • https://sgm.docs.bluehorizonsgroup.com"
echo "  • https://aicr.docs.bluehorizonsgroup.com"
echo "  • https://rally.docs.bluehorizonsgroup.com"
echo "  • https://towedge.docs.bluehorizonsgroup.com"
echo "  • https://psedge.docs.bluehorizonsgroup.com"
echo "  • https://sfp.docs.bluehorizonsgroup.com"
echo "  • https://ispm.docs.bluehorizonsgroup.com"
echo "  • https://docai.docs.bluehorizonsgroup.com"
