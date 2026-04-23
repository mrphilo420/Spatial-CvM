# AI + VS Code Theorem Prover Integration

## Overview

This setup provides multiple ways to integrate AI capabilities (Hermes Agent, Claude Code) with VS Code for mathematical theorem proving.

## What Was Created

1. **`claude-theoreprover.sh`** - Launch script to start Claude Code with VS Code integration
2. **`example-lean-project/`** - A complete Lean 4 theorem proving project with examples
3. **`.vscode/settings.json`** - VS Code configuration optimized for theorem proving
4. **`MathTheorems/NatTheorems.lean`** - Example theorems about natural numbers

## How to Use

### Option 1: Use Claude Code in VS Code

VS Code has native integration with Claude Code. To use it:

```bash
# In your Lean/CLean/Isabelle project directory
claude --ide "Help me complete this proof"
```

The `--ide` flag connects Claude Code to VS Code for file editing and proof assistance.

### Option 2: Spawn from Hermes Agent

You can spawn Claude Code from Hermes to work on theorems:

```python
# Launch Claude Code in print mode
terminal(command="cd ~/lean-project && claude -p 'Help me prove this theorem' --allowedTools 'Read,Edit,Bash' --max-turns 10", timeout=120)
```

### Option 3: Hermes as MCP Server (Advanced)

Configure Hermes as an MCP server in VS Code to get native tool access.

## Example Theorems in the Project

The `example-lean-project` includes:

```lean
theorem add_comm_nat (a b : ℕ) : a + b = b + a := by ring

theorem zero_add (n : ℕ) : 0 + n = n := by rfl

theorem mul_add_distrib (a b c : ℕ) : a * (b + c) = a * b + a * c := by ring
```

## VS Code Extensions Recommended

Run this in VS Code:
```json
{
  "recommendations": [
    "leanprover.lean4",      // Lean 4 language support
    "mhutchie.git-graph",      // Git visualization
    "usernamehw.errorlens"       // Better error highlighting
  ]
}
```

## Supported Theorem Provers

- **Lean 4** - Modern, powerful, excellent math library (mathlib4)
- **Coq** - Classical theorem prover
- **Isabelle/HOL** - Great automation, readable proofs
- **Metamath** - Minimalist, fully verifiable

## Files Overview

```
theorem-prover-setup/
├── README.md                    # This file
├── claude-theoreprover.sh       # Launcher script
├── vscode-integration.json      # VS Code extension config
└── example-lean-project/
    ├── lean-toolchain          # Lean version specification
    ├── lakefile.lean           # Project build configuration
    ├── MathTheorems/
    │   └── NatTheorems.lean    # Example theorems about naturals
    └── .vscode/
        └── settings.json       # VS Code settings for theorem proving
```

## Next Steps

1. Open the `example-lean-project` folder in VS Code
2. Install the Lean 4 extension (`leanprover.lean4`)
3. Run `lake build` to build the project
4. Start theorem proving with AI assistance!

## Commands Available

From within VS Code with Claude Code:
- "Help me prove the Pythagorean theorem"
- "Complete this proof using induction"
- "Explain this tactic"
- "Search for lemmas about prime numbers"
- "Fix this error in my proof"
