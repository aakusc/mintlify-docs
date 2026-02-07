# Blue Horizons Group Documentation Monorepo

> Multi-product Mintlify documentation repository with independent deployment per product

## 📚 Documentation Sites

This monorepo hosts documentation for the entire Blue Horizons Group product suite. Each product has its own independent Mintlify site that can be deployed to a unique subdomain.

| Product | Directory | Subdomain | Status |
|---------|-----------|-----------|--------|
| **SGM SPARCC** | `docs/sgm-sparcc/` | sgm.docs.bluehorizonsgroup.com | ✅ Production |
| **AICR Platform** | `docs/aicr-platform/` | aicr.docs.bluehorizonsgroup.com | 🚧 In Development |
| **Rally Stack** | `docs/rally-stack/` | rally.docs.bluehorizonsgroup.com | 🚧 In Development |
| **TowEdge** | `docs/towedge/` | towedge.docs.bluehorizonsgroup.com | 📝 Planned |
| **PS Edge** | `docs/ps-edge/` | psedge.docs.bluehorizonsgroup.com | 📝 Planned |
| **SFP** | `docs/sfp/` | sfp.docs.bluehorizonsgroup.com | 📝 Planned |
| **IntelligentSPM** | `docs/intelligentspm/` | ispm.docs.bluehorizonsgroup.com | 🔜 Coming Soon |
| **Document Intelligence** | `docs/document-intelligence/` | docai.docs.bluehorizonsgroup.com | 🔜 Coming Soon |

## 🏗️ Repository Structure

```
docs-main/
├── docs/                          # All documentation sites
│   ├── sgm-sparcc/               # Sales Compensation Management
│   ├── aicr-platform/            # AICR Platform (Studio/Edge/Summit)
│   ├── rally-stack/              # AICodeRally Ecosystem
│   ├── towedge/                  # TowEdge Platform
│   ├── ps-edge/                  # Nonprofit Platform
│   ├── sfp/                      # Startup Financial Planning
│   ├── intelligentspm/           # IntelligentSPM (Planned)
│   └── document-intelligence/    # Document Analyzer (Coming Soon)
│
├── shared/                       # Shared resources
│   ├── components/               # Reusable MDX components
│   ├── images/                   # Shared images/logos
│   └── snippets/                 # Reusable content snippets
│
├── package.json                  # Monorepo scripts
└── README.md                     # This file
```

## 🚀 Quick Start

### Prerequisites

- Node.js 18+ and npm
- Mintlify CLI installed globally

```bash
npm install -g mintlify
```

### Development

Run any documentation site locally:

```bash
# SGM SPARCC
npm run dev:sgm

# AICR Platform
npm run dev:aicr

# Rally Stack
npm run dev:rally

# TowEdge
npm run dev:towedge

# PS Edge
npm run dev:psedge

# SFP
npm run dev:sfp

# IntelligentSPM
npm run dev:ispm

# Document Intelligence
npm run dev:docai
```

Each site will start at `http://localhost:3000` by default.

### Building

Build all documentation sites:

```bash
npm run build:all
```

Or build individual sites:

```bash
npm run build:sgm
npm run build:aicr
npm run build:rally
# ... etc
```

### Validation

Validate all documentation sites:

```bash
npm run validate:all
```

Or validate individual sites:

```bash
npm run validate:sgm
npm run validate:aicr
# ... etc
```

## 📝 Adding a New Product

1. **Create directory structure:**

```bash
mkdir -p docs/new-product/docs
mkdir -p docs/new-product/api-reference
```

2. **Create mint.json configuration:**

```json
{
  "$schema": "https://mintlify.com/schema.json",
  "name": "Product Name",
  "colors": {
    "primary": "#066aab",
    "light": "#3666b0",
    "dark": "#044a78"
  },
  "navigation": [
    {
      "group": "Getting Started",
      "pages": ["docs/introduction"]
    }
  ]
}
```

3. **Create introduction.mdx:**

```mdx
---
title: Introduction
description: 'Welcome to Product Name'
---

## What is Product Name?

Your product description here...
```

4. **Add npm scripts to package.json:**

```json
{
  "scripts": {
    "dev:newproduct": "cd docs/new-product && mintlify dev",
    "build:newproduct": "cd docs/new-product && mintlify build",
    "validate:newproduct": "cd docs/new-product && mintlify validate"
  }
}
```

5. **Update this README** with the new product information.

## 🎨 Brand Guidelines

All documentation sites use the Blue Horizons Group color scheme:

| Color | Hex Code | Usage |
|-------|----------|-------|
| **Primary Blue** | `#066aab` | Primary buttons, CTAs, links |
| **Light Blue** | `#3666b0` | Hover states, secondary accents |
| **Dark Blue** | `#044a78` | Dark mode primary |
| **Coral/Rust Red** | `#dc716d` | Icons, highlights, visual accents |

## 📦 Deployment

Each product documentation site is deployed independently to its own subdomain:

### Mintlify Deployment

1. **Connect to Mintlify:**
   - Go to [Mintlify Dashboard](https://dashboard.mintlify.com)
   - Connect your GitHub repository
   - Select the specific docs directory (e.g., `docs/sgm-sparcc`)

2. **Configure subdomain:**
   - Set custom domain to `sgm.docs.bluehorizonsgroup.com`
   - Add DNS records as instructed by Mintlify
   - Repeat for each product

3. **Auto-deploy:**
   - Mintlify automatically deploys on push to main branch
   - Each product deploys independently based on file changes

### Manual Deployment

```bash
# Deploy specific product
cd docs/sgm-sparcc
mintlify deploy

# Deploy all products
npm run build:all
```

## 🔧 Shared Resources

The `shared/` directory contains resources used across multiple documentation sites:

- **Components**: Reusable MDX components
- **Images**: Shared logos, icons, brand assets
- **Snippets**: Common content blocks

### Using Shared Resources

```mdx
<!-- Import shared component -->
import { CustomCard } from '@shared/components/CustomCard'

<CustomCard title="Example" />

<!-- Reference shared image -->
<img src="/shared/images/logo.png" alt="BHG Logo" />

<!-- Include shared snippet -->
<Snippet file="shared/snippets/common-prerequisites.mdx" />
```

## 📖 Documentation Standards

### File Naming

- Use kebab-case for file names: `getting-started.mdx`
- Use descriptive names: `installation-guide.mdx` not `guide.mdx`

### Content Structure

Each documentation site should include:

1. **Introduction** (`introduction.mdx`) - Product overview
2. **Quickstart** (`quickstart.mdx`) - 5-minute getting started guide
3. **Core Concepts** - Key concepts and architecture
4. **User Guides** - Step-by-step tutorials
5. **API Reference** - API documentation
6. **Reference** - Additional reference materials

### Writing Style

- Use clear, concise language
- Include code examples where applicable
- Add diagrams for complex concepts (use Mermaid)
- Use callouts for important information (<Note>, <Warning>, <Tip>)
- Maintain consistent terminology across all docs

## 🤝 Contributing

1. **Create a feature branch:**

```bash
git checkout -b docs/product-name/feature-description
```

2. **Make your changes:**
   - Edit existing documentation
   - Add new pages
   - Update navigation in mint.json

3. **Validate locally:**

```bash
npm run dev:product-name
npm run validate:product-name
```

4. **Commit and push:**

```bash
git add .
git commit -m "docs(product-name): description of changes"
git push origin docs/product-name/feature-description
```

5. **Create pull request** targeting the `main` branch

## 📋 Available Scripts

| Script | Description |
|--------|-------------|
| `npm run list` | List all available documentation sites |
| `npm run dev:*` | Run development server for specific product |
| `npm run build:*` | Build specific product documentation |
| `npm run build:all` | Build all documentation sites |
| `npm run validate:*` | Validate specific product docs |
| `npm run validate:all` | Validate all documentation sites |
| `npm run install:mintlify` | Install Mintlify CLI globally |

## 🐛 Troubleshooting

### Mintlify CLI not found

```bash
npm run install:mintlify
```

### Port already in use

Mintlify uses port 3000 by default. Kill existing processes or specify a different port:

```bash
cd docs/product-name
mintlify dev --port 3001
```

### Build errors

Validate your documentation before building:

```bash
npm run validate:product-name
```

Common issues:
- Missing required fields in `mint.json`
- Broken internal links
- Invalid MDX syntax
- Missing images or assets

## 📞 Support

- **Documentation Issues**: Create an issue in this repository
- **Product Questions**: Contact support@bluehorizonsgroup.com
- **Mintlify Support**: https://mintlify.com/docs

## 📄 License

Proprietary - Blue Horizons Group. All rights reserved.

---

**Last Updated**: February 2026
**Maintained by**: Blue Horizons Group Documentation Team
