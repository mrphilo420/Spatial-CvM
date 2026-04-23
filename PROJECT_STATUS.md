# SpatialCvM Project - Reorganization 2026-04-23

## Folder Structure

This project has been reorganized to separate ACTIVE development files from ARCHIVED/LEGACY content.

---

## ACTIVE Files (Currently Being Compiled)

### `SpatialCvM/active/src/`
- **CLT.lean** - Central Limit Theorem with Davydov (1970) bounds integrated
- **Lemma1.lean** - Core lemmas including F_hat variance formula, sigma-algebra inclusions
- **Main.lean** - Entry point

### `SpatialCvM/active/lemmas/`
- **RiemannSum.lean** - Riemann sum convergence lemmas
- **Integrability.lean** - Integrability conditions for kernels

---

## LEGACY Files (Reference - Original Multi-File Structure)

### `SpatialCvM/legacy/`
Contains the original development structure:
- `Theorem1/` - Variance convergence proofs
- `Theorem2/` - Asymptotic theory
- `Theorem3/` - Limit distribution
- `Lemma1/` - Base lemmas
- `Calibration/` - Satterthwaite, eigenvalues, discrete covariance
- `Definitions/` - Basic, Copula, Kernel, Lattice, RandomField
- `Proofs/` - Summation complete, Lag regroup
- `Utils/` - Measure theory, Asymptotics, Tactics

---

## ARCHIVE/BROKEN (Retired Attempts)

### `SpatialCvM/archive/broken/`
Contains `_new_broken` directories that were unsuccessful refactoring attempts.
These can be permanently deleted later after review:
- `Theorem1_new_broken/`
- `Theorem2_new_broken/`
- `Lemma1_new_broken/`
- `Proofs_new_broken/`
- `Calibration_new_broken/`

---

## Documentation

### `documentation/project/`
Project management and planning:
- README.md
- IMPLEMENTATION_PLAN.md
- IMPLEMENTATION_STATUS.md
- PROJECT_TIMELINE_AND_ESSENTIALS.md

### `documentation/literature/`
Literature synthesis and theory:
- COMPLETE_MATHEMATICAL_SYNTHESIS.md
- MATHEMATICAL_SYNTHESIS.md
- CONWAY_SPECTRAL_THEORY_SUMMARY.md
- LITERATURE_IMPLEMENTATION_REPORT.md

### `documentation/progress/`
Progress tracking and assessments:
- COMPREHENSIVE_PROGRESS_SUMMARY.md
- PROGRESS_INTEGRATION_REPORT.md
- HONEST_ASSESSMENT.md
- REMAINING_ROADMAP.md
- REFERENCE_REQUIREMENTS.md
- PRIORITY_FIXES_PLAN.md
- FIXES_STATUS.md
- NEW_REFERENCES_SUMMARY.md
- PDF_EXTRACTION_STATUS.md

### `documentation/`
(Other docs moved here for now)

---

## Archive

### `archive/json_conversations/`
Hermes conversation history:
- hermes_conversation_20260423_001736.json
- hermes_conversation_20260423_093039.json

### `archive/tex_documents/`
LaTeX manuscripts (can be retired):
- SpatialCvM_Asymptotic_Theory.tex
- SpatialCvM_Elsevier_3p.tex

### `archive/source_backup/`
(Empty - for backups before major changes)

---

## Research Materials (Keep As Is)

### `literature_extracts/`
Extracted text and data from PDF papers.

### `related_studies/`
PDF papers including Davydov (1970) original Russian paper.

---

## Build/Development

- `lakefile.toml` - Lake build configuration
- `lean-toolchain` - Lean version specification
- `lake/` - Build artifacts
- `.github/` - CI/CD workflows

---

## Key Recent Changes (2026-04-23)

1. **Integrated Davydov (1970)** original paper lemmas into CLT.lean
2. **Added F_hat_variance_formula** and **covariance_as_gamma**
3. **Simplified structure** - working code now in `active/` directory
4. **Preserved legacy** - original multi-file structure in `legacy/`
5. **Archived broken** - failed attempts in `archive/broken/`

---

## Next Steps

1. Update `lakefile.toml` to compile files from `active/src/` and `active/lemmas/`
2. Delete `archive/broken/` permanently after review (optional)
3. Delete `archive/tex_documents/` after confirming no longer needed
4. Continue development in streamlined `active/` structure

---

## Current Sorry Count

- CLT.lean: ~15 sorrys
- Lemma1.lean: ~11 sorrys

Main remaining challenges:
- Davydov inequality proofs (require Hölder's inequality)
- Variance expansion (Riemann sum → integral)
- Main SpatialCLT theorem
