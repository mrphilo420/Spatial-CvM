# VS Code + AI Theorem Prover Setup

This setup integrates AI capabilities with VS Code for mathematical theorem proving using multiple approaches.

## Approaches Available

### 1. Claude Code (Recommended)
- Native VS Code extension support
- Excellent for formal proofs in Lean 4, Coq, Isabelle
- Can read/write files and run theorem provers
- Launch: `claude` with `--ide` flag in your project directory

### 2. Hermes Agent via Claude Code Bridge
- Hermes can spawn Claude Code as a subagent
- Access to theorem prover tools via Hermes
- Can coordinate with other tools

### 3. MCP Server Integration (Advanced)
- Connect Hermes directly to VS Code via MCP
- Real-time tool access from VS Code

## Quick Start

### Method 1: VS Code Extension (Simplest)

1. Install the VS Code extension:
   - Claude Code in VS Code marketplace
   - Or connect via Claude Code CLI

2. In VS Code terminal, run:
   ```
   claude --ide "Prove the Pythagorean theorem in Lean 4"
   ```

### Method 2: Hermes + Claude Code Integration

From within Hermes, you can spawn Claude Code to work in VS Code:

```
# Spawn Claude Code in your theorem proving project
terminal(command="cd ~/lean-project && claude -p 'Set up basic lemmas for group theory' --allowedTools 'Read,Edit,Bash'", timeout=120)
```

## Supported Theorem Provers

- **Lean 4** (Recommended) - Modern, powerful, excellent math library
- **Coq** - Classical, very robust
- **Isabelle/HOL** - Great automation, readable proofs
- **Metamath** - Minimalist, verifiable
- **Lean 3** - Previous version with mathlib

## Example: Starting a Lean 4 Proof in VS Code

```bash
# Navigate to your Lean project
cd ~/lean4-maths

# Start Claude Code with IDE connection
claude --ide "Help me prove the fundamental theorem of calculus"
```

## Tools Available

When integrated, you have access to:
- File editing in VS Code
- Running Lean/Coq/etc. to check proofs
- Library search
- Proof suggestion and completion
- Error interpretation

## Configuration Files

- `lean-toolchain` - Lean version specification
- `lakefile.lean` - Lean project configuration
- `.vscode/settings.json` - VS Code theorem prover settings
