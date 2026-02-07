# Shared Resources

This directory contains shared resources used across multiple documentation sites in the monorepo.

## Directory Structure

```
shared/
├── components/      # Reusable MDX components
├── images/          # Shared images, logos, icons
└── snippets/        # Reusable content snippets
```

## Usage

### Components

Create reusable MDX components that can be imported across different documentation sites:

```mdx
import { CustomCard } from '@shared/components/CustomCard'

<CustomCard title="Example" />
```

### Images

Store shared images like logos, brand assets, and common diagrams:

```mdx
<img src="/shared/images/logo.png" alt="BHG Logo" />
```

### Snippets

Store reusable content snippets that appear across multiple docs:

```mdx
<Snippet file="shared/snippets/common-prerequisites.mdx" />
```

## Best Practices

1. **Keep it DRY**: Only add content that is truly shared across multiple products
2. **Version Control**: Use semantic versioning for breaking changes to shared components
3. **Documentation**: Document each shared component with usage examples
4. **Testing**: Test shared components across all documentation sites before committing
