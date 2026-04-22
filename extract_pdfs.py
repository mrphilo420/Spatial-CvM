#!/usr/bin/env python3
import fitz  # PyMuPDF
import os

pdf_files = [
    ("related studies/wasserman_2006_nonparametric.pdf", "wasserman_2006_nonparametric.txt"),
    ("related studies/discrete approximation.pdf", "discrete_approximation.txt"),
    ("related studies/mathematics-12-03467.pdf", "mathematics_12_03467.txt"),
    ("related studies/AIHPB_2002__38_6_879_0.pdf", "AIHPB_2002.txt"),
    ("related studies/dewet1980.pdf", "dewet1980.txt"),
    ("related studies/RM_702.pdf", "RM_702.txt"),
    ("related studies/empirical_process_1989.pdf", "empirical_process_1989.txt"),
    ("related studies/dehling_taqqu_1989.pdf", "dehling_taqqu_1989.txt"),
    ("related studies/cvm_functional_step.pdf", "cvm_functional_step.txt"),
    ("related studies/goodness_of_fit_dependent.pdf", "goodness_of_fit_dependent.txt"),
    ("related studies/spatial_correction_plugin.pdf", "spatial_correction_plugin.txt"),
]

output_dir = "literature_extracts"
os.makedirs(output_dir, exist_ok=True)

for pdf_path, output_name in pdf_files:
    if os.path.exists(pdf_path):
        try:
            print(f"Processing: {pdf_path}")
            doc = fitz.open(pdf_path)
            full_text = f"{'='*70}\n"
            full_text += f"SOURCE: {os.path.basename(pdf_path)}\n"
            full_text += f"{'='*70}\n\n"
            
            for page_num in range(len(doc)):
                page = doc[page_num]
                full_text += f"\n--- Page {page_num + 1} ---\n"
                full_text += page.get_text()
            
            doc.close()
            
            output_path = os.path.join(output_dir, output_name)
            with open(output_path, 'w', encoding='utf-8') as f:
                f.write(full_text)
            print(f"  ✓ Extracted to {output_path}")
            
        except Exception as e:
            print(f"  ✗ Error: {e}")
    else:
        print(f"  ✗ File not found: {pdf_path}")

print("\nDone!")
