# Quick Deployment Guide

## Mintlify Deployment - Monorepo Setup

Since this is a monorepo with multiple documentation sites, each product needs to be deployed separately.

## Method 1: Mintlify Dashboard (EASIEST)

### For Each Product:

1. **Go to [Mintlify Dashboard](https://dashboard.mintlify.com)**
2. **Click "New Documentation"**
3. **Connect GitHub Repository**
   - Select: `docs-main` repository
4. **Configure Root Directory**
   - **IMPORTANT**: Set the "Root Directory" to the product folder:

   | Product | Root Directory |
   |---------|---------------|
   | SGM SPARCC | `docs/sgm-sparcc` |
   | AICR Platform | `docs/aicr-platform` |
   | Rally Stack | `docs/rally-stack` |
   | TowEdge | `docs/towedge` |
   | PS Edge | `docs/ps-edge` |
   | SFP | `docs/sfp` |
   | IntelligentSPM | `docs/intelligentspm` |
   | Document Intelligence | `docs/document-intelligence` |

5. **Set Custom Domain**
   - Enter the subdomain for each product:
     - `sgm.docs.bluehorizonsgroup.com`
     - `aicr.docs.bluehorizonsgroup.com`
     - etc.

6. **Add DNS Records**
   - Mintlify will provide CNAME records
   - Add them to your DNS provider (Cloudflare, Route53, etc.)

## Method 2: CLI Deployment

### Deploy Individual Sites

```bash
# SGM SPARCC
cd docs/sgm-sparcc
mintlify deploy

# AICR Platform
cd ../aicr-platform
mintlify deploy

# Rally Stack
cd ../rally-stack
mintlify deploy

# Continue for each product...
```

### Deploy All Sites (Script)

```bash
#!/bin/bash
# Run from docs-main root directory

PRODUCTS=("sgm-sparcc" "aicr-platform" "rally-stack" "towedge" "ps-edge" "sfp" "intelligentspm" "document-intelligence")

for product in "${PRODUCTS[@]}"; do
  echo "Deploying $product..."
  cd "docs/$product"
  mintlify deploy
  cd ../..
  echo "✓ $product deployed"
  echo ""
done

echo "All sites deployed!"
```

Save this as `deploy-all.sh` in the root, make it executable, and run:

```bash
chmod +x deploy-all.sh
./deploy-all.sh
```

## Testing Locally

Test each documentation site locally before deploying:

```bash
# Use npm scripts (from root)
npm run dev:sgm      # Test SGM
npm run dev:aicr     # Test AICR
npm run dev:rally    # Test Rally Stack
# etc.

# Or manually from each directory
cd docs/sgm-sparcc
mintlify dev
```

## Troubleshooting

### "Unable to find mint.json"

**Problem**: Running mintlify commands from wrong directory

**Solution**: Always run from inside the product directory:
```bash
cd docs/sgm-sparcc   # Correct
mintlify dev

# NOT from root:
# mintlify dev  # Wrong - no mint.json at root level
```

### "Repository not found" on GitHub

**Solution**: Make sure you've pushed to GitHub:
```bash
git push origin main
```

### Build Errors

**Solution**: Validate before deploying:
```bash
cd docs/sgm-sparcc
mintlify validate
```

## DNS Configuration

After deploying in Mintlify Dashboard, add these CNAME records:

| Subdomain | Type | Value |
|-----------|------|-------|
| `sgm.docs` | CNAME | [provided by Mintlify] |
| `aicr.docs` | CNAME | [provided by Mintlify] |
| `rally.docs` | CNAME | [provided by Mintlify] |
| `towedge.docs` | CNAME | [provided by Mintlify] |
| `psedge.docs` | CNAME | [provided by Mintlify] |
| `sfp.docs` | CNAME | [provided by Mintlify] |
| `ispm.docs` | CNAME | [provided by Mintlify] |
| `docai.docs` | CNAME | [provided by Mintlify] |

## Verification

Once deployed and DNS is configured, verify each site:

- ✅ https://sgm.docs.bluehorizonsgroup.com
- ✅ https://aicr.docs.bluehorizonsgroup.com
- ✅ https://rally.docs.bluehorizonsgroup.com
- ✅ https://towedge.docs.bluehorizonsgroup.com
- ✅ https://psedge.docs.bluehorizonsgroup.com
- ✅ https://sfp.docs.bluehorizonsgroup.com
- ✅ https://ispm.docs.bluehorizonsgroup.com
- ✅ https://docai.docs.bluehorizonsgroup.com

## Auto-Deployment

Mintlify automatically deploys when you push to GitHub. Each product deploys independently based on file changes in its directory.

To enable auto-deployment:
1. Configure each product in Mintlify Dashboard
2. Connect to GitHub repository
3. Push changes to `main` branch
4. Mintlify deploys automatically (2-3 minutes)

---

**Need Help?** See [DEPLOYMENT.md](DEPLOYMENT.md) for comprehensive deployment guide.
