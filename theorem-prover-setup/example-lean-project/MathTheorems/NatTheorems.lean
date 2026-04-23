import Mathlib.Data.Nat.Basic
import Mathlib.Tactic

namespace MathTheorems

-- Basic theorems about natural numbers

/-- 
Addition is commutative for natural numbers.
This is a fundamental property that we'll prove.
-/
theorem add_comm_nat (a b : ℕ) : a + b = b + a := by
  -- We use the `ring` tactic which can solve basic algebraic identities
  ring

/--
Zero is the identity element for addition.
For any natural number n, we have n + 0 = n.
-/
theorem zero_add (n : ℕ) : 0 + n = n := by
  -- This is true by the definition of addition
  rfl

/--
Multiplication distributes over addition.
This is one of the fundamental properties of arithmetic.
-/
theorem mul_add_distrib (a b c : ℕ) : a * (b + c) = a * b + a * c := by
  -- The `ring` tactic can handle this distributive property
  ring

/--
For any natural number n, n ≤ n (reflexivity of ≤).
-/
theorem le_refl_nat (n : ℕ) : n ≤ n := by
  -- This follows directly from the definition
  exact Nat.le_refl n

/--
If a ≤ b and b ≤ c, then a ≤ c (transitivity of ≤).
-/
theorem le_trans_nat {a b c : ℕ} (h₁ : a ≤ b) (h₂ : b ≤ c) : a ≤ c := by
  -- Use the transitivity property from Mathlib
  exact Nat.le_trans h₁ h₂

/--
Every natural number is either zero or a successor.
This is a fundamental property used in induction.
-/
theorem is_succ_or_zero (n : ℕ) : n = 0 ∨ ∃ k : ℕ, n = k + 1 := by
  cases n with
  | zero =>
    -- If n = 0, left side is true
    left
    rfl
  | succ m =>
    -- If n = m + 1, right side is true
    right
    use m
    rfl

end MathTheorems