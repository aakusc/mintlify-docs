# Mintlify Deployment Guide

> Step-by-step guide for deploying multiple Mintlify documentation sites to subdomains

## Overview

This monorepo contains 8 independent Mintlify documentation sites, each deployed to its own subdomain under `docs.bluehorizonsgroup.com`.

## Subdomain Mapping

| Product | Directory | Subdomain |
|---------|-----------|-----------|
| SGM SPARCC | `docs/sgm-sparcc/` | `sgm.docs.bluehorizonsgroup.com` |
| AICR Platform | `docs/aicr-platform/` | `aicr.docs.bluehorizonsgroup.com` |
| Rally Stack | `docs/rally-stack/` | `rally.docs.bluehorizonsgroup.com` |
| TowEdge | `docs/towedge/` | `towedge.docs.bluehorizonsgroup.com` |
| PS Edge | `docs/ps-edge/` | `psedge.docs.bluehorizonsgroup.com` |
| SFP | `docs/sfp/` | `sfp.docs.bluehorizonsgroup.com` |
| IntelligentSPM | `docs/intelligentspm/` | `ispm.docs.bluehorizonsgroup.com` |
| Document Intelligence | `docs/document-intelligence/` | `docai.docs.bluehorizonsgroup.com` |

## Deployment Methods

### Method 1: Mintlify Dashboard (Recommended)

This is the easiest method for deploying and managing multiple documentation sites.

#### Step 1: Connect GitHub Repository

1. Go to [Mintlify Dashboard](https://dashboard.mintlify.com)
2. Click "New Documentation"
3. Connect your GitHub account if not already connected
4. Select the `docs-main` repository

#### Step 2: Configure Each Product Site

For **each product**, repeat these steps:

1. **Create New Site:**
   - Click "New Documentation"
   - Select `docs-main` repository
   - Choose the product directory (e.g., `docs/sgm-sparcc`)

2. **Set Root Directory:**
   - In site settings, set "Root Directory" to the product path:
     - SGM: `docs/sgm-sparcc`
     - AICR: `docs/aicr-platform`
     - Rally: `docs/rally-stack`
     - etc.

3. **Configure Custom Domain:**
   - Go to site settings → "Custom Domain"
   - Enter the subdomain (e.g., `sgm.docs.bluehorizonsgroup.com`)
   - Mintlify will provide DNS records to add

#### Step 3: Configure DNS Records

Add the following DNS records in your domain provider (e.g., Cloudflare, Route53):

For each subdomain, add:

**CNAME Record:**
```
Type: CNAME
Name: sgm.docs (or aicr.docs, rally.docs, etc.)
Value: [provided by Mintlify]
TTL: Auto
```

Repeat for all 8 subdomains:
- `sgm.docs`
- `aicr.docs`
- `rally.docs`
- `towedge.docs`
- `psedge.docs`
- `sfp.docs`
- `ispm.docs`
- `docai.docs`

#### Step 4: Verify Deployment

1. Wait for DNS propagation (5-30 minutes)
2. Visit each subdomain to verify:
   - `https://sgm.docs.bluehorizonsgroup.com`
   - `https://aicr.docs.bluehorizonsgroup.com`
   - etc.

3. Check SSL certificates are active (Mintlify auto-provisions)

### Method 2: Mintlify CLI Deployment

For manual deployment using the CLI:

#### Prerequisites

```bash
npm install -g mintlify
```

#### Deploy Individual Sites

```bash
# SGM SPARCC
cd docs/sgm-sparcc
mintlify deploy

# AICR Platform
cd docs/aicr-platform
mintlify deploy

# Repeat for each product...
```

#### Deploy All Sites (Script)

Create a deployment script:

```bash
#!/bin/bash
# deploy-all.sh

echo "Deploying all documentation sites..."

PRODUCTS=("sgm-sparcc" "aicr-platform" "rally-stack" "towedge" "ps-edge" "sfp" "intelligentspm" "document-intelligence")

for product in "${PRODUCTS[@]}"; do
  echo "Deploying $product..."
  cd "docs/$product"
  mintlify deploy
  cd ../..
done

echo "All sites deployed!"
```

Make it executable and run:

```bash
chmod +x deploy-all.sh
./deploy-all.sh
```

## Auto-Deployment with GitHub Actions

Set up automatic deployment on push to main branch.

### Create Workflow File

`.github/workflows/deploy-docs.yml`:

```yaml
name: Deploy Documentation

on:
  push:
    branches:
      - main
    paths:
      - 'docs/**'

jobs:
  deploy:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        product:
          - sgm-sparcc
          - aicr-platform
          - rally-stack
          - towedge
          - ps-edge
          - sfp
          - intelligentspm
          - document-intelligence

    steps:
      - name: Checkout
        uses: actions/checkout@v3

      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'

      - name: Install Mintlify CLI
        run: npm install -g mintlify

      - name: Deploy ${{ matrix.product }}
        run: |
          cd docs/${{ matrix.product }}
          mintlify deploy
        env:
          MINTLIFY_API_KEY: ${{ secrets.MINTLIFY_API_KEY }}
```

### Set Up Secrets

1. Go to your GitHub repository settings
2. Navigate to "Secrets and variables" → "Actions"
3. Add `MINTLIFY_API_KEY` (get from Mintlify Dashboard)

## Deployment Checklist

Before deploying each product, verify:

- [ ] `mint.json` is properly configured
- [ ] All navigation pages exist
- [ ] Images and assets are in place
- [ ] `introduction.mdx` exists
- [ ] No broken internal links
- [ ] Colors match BHG brand guidelines
- [ ] Custom domain is configured in Mintlify Dashboard
- [ ] DNS records are added

### Validation Command

Run before deploying:

```bash
npm run validate:sgm
npm run validate:aicr
npm run validate:rally
# ... etc
```

Or validate all at once:

```bash
npm run validate:all
```

## Monitoring & Maintenance

### Check Deployment Status

1. Visit [Mintlify Dashboard](https://dashboard.mintlify.com)
2. View all sites and their deployment status
3. Check analytics and usage metrics

### Update Documentation

1. Make changes to docs in the repository
2. Commit and push to `main` branch
3. Mintlify auto-deploys within 2-3 minutes
4. Verify changes on the live subdomain

### Rollback

If a deployment fails or has issues:

1. Go to Mintlify Dashboard
2. Select the problematic site
3. Click "Deployments"
4. Rollback to previous successful deployment

## Troubleshooting

### DNS Not Resolving

**Problem:** Subdomain not resolving after DNS setup

**Solution:**
1. Check DNS records are correct (CNAME pointing to Mintlify)
2. Wait for DNS propagation (can take up to 48 hours)
3. Use `dig` or `nslookup` to verify:
   ```bash
   dig sgm.docs.bluehorizonsgroup.com
   ```

### SSL Certificate Issues

**Problem:** SSL certificate not active or showing errors

**Solution:**
1. Mintlify auto-provisions SSL via Let's Encrypt
2. Can take 10-30 minutes after DNS resolves
3. If persists after 1 hour, contact Mintlify support

### Build Failures

**Problem:** Deployment fails with build errors

**Solution:**
1. Run validation locally:
   ```bash
   npm run validate:product-name
   ```
2. Check for:
   - Missing pages referenced in navigation
   - Invalid MDX syntax
   - Broken image links
   - Incorrect mint.json configuration

### 404 Errors on Pages

**Problem:** Some pages return 404

**Solution:**
1. Verify page paths in `mint.json` match actual files
2. Ensure file extensions are `.mdx` not `.md`
3. Check case sensitivity (use lowercase file names)
4. Verify relative paths are correct

### Slow Deployment

**Problem:** Deployment taking longer than expected

**Solution:**
1. Check Mintlify status page
2. Large sites take longer (more pages/images)
3. Deploy during off-peak hours if possible

## Best Practices

### Branch Strategy

- `main` branch → Production deployment (auto-deploys)
- Feature branches → No auto-deploy (test locally)
- Use pull requests for all changes

### Testing Before Deployment

Always test locally before pushing:

```bash
npm run dev:product-name
```

Navigate through all pages, check:
- All links work
- Images load correctly
- Navigation is intuitive
- Code blocks render properly

### Staged Rollout

When making major changes:

1. Deploy to one product first (e.g., a "coming soon" site)
2. Verify it works correctly
3. Apply same changes to other products
4. Deploy remaining products

### Documentation Updates

Keep these files updated:
- `README.md` - Monorepo overview
- `DEPLOYMENT.md` - This file
- Individual `mint.json` files - Navigation structure

## Support & Resources

- **Mintlify Documentation**: https://mintlify.com/docs
- **Mintlify Dashboard**: https://dashboard.mintlify.com
- **Mintlify Support**: support@mintlify.com
- **BHG Internal**: support@bluehorizonsgroup.com

## Post-Deployment Checklist

After deploying all sites:

- [ ] All 8 subdomains resolve correctly
- [ ] SSL certificates are active on all sites
- [ ] Homepage (introduction.mdx) loads on each site
- [ ] Navigation works and all pages accessible
- [ ] Images and assets load correctly
- [ ] Brand colors are consistent
- [ ] Footer links work
- [ ] Search functionality works
- [ ] Analytics tracking is enabled
- [ ] Custom domain configuration is complete

---

**Last Updated**: February 2026
**Maintained by**: Blue Horizons Group Documentation Team
