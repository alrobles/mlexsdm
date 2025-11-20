# Code Consolidation

This directory contains scripts to consolidate all source code into a single plain text file for easy sharing.

## Usage

### Python Script (Recommended)

```bash
python3 generate_code_text.py
```

### R Script

```r
source("generate_code_text.R")
generate_code_text()
```

## Output

The script generates a file called `all_code.txt` which contains:
- All R source files from the `R/` directory
- All C++ source files from the `src/` directory
- Clear headers separating each file
- Metadata about when the file was generated

The consolidated file can be easily shared with collaborators, attached to emails, or used for code review purposes.

## Customization

You can specify a custom output filename:

**Python:**
```python
from generate_code_text import generate_code_text
generate_code_text(output_file="my_custom_code.txt")
```

**R:**
```r
source("generate_code_text.R")
generate_code_text(output_file = "my_custom_code.txt")
```

## File Structure

The generated file includes:
1. Header with package name, generation date, and description
2. Each source file with clear separators
3. File path for easy reference
4. Footer with summary statistics
