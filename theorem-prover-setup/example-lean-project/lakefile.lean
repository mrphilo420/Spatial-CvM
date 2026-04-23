import Lake
open Lake DSL

package «math-theorems» where
  -- Settings applied to both builds and interactive editing
  leanOptions := #[
    ⟨`relaxedAutoImplicit, true⟩,
    ⟨`linter.unusedVariables, false⟩ -- Quiet linter
  ]
  -- Add additional configuration options here
  
require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.5.0"

@[default_target]
lean_lib «MathTheorems» where
  -- Configures the library for building
  roots := #[`MathTheorems]
