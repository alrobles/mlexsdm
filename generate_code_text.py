#!/usr/bin/env python3
"""
Script to consolidate all source code into a single plain text file
This makes it easy to share the entire codebase
"""

import os
from datetime import datetime
from pathlib import Path


def generate_code_text(output_file="all_code.txt"):
    """
    Consolidate all R and C++ source code files into a single plain text file.
    
    Args:
        output_file: Name of the output file (default: all_code.txt)
    
    Returns:
        Path to the generated file
    """
    # Define directories to scan for code
    code_dirs = ["R", "src"]
    
    # File extensions to include
    extensions = [".R", ".cpp", ".h"]
    
    # Collect all files
    all_files = []
    for dir_name in code_dirs:
        dir_path = Path(dir_name)
        if dir_path.exists() and dir_path.is_dir():
            for file_path in dir_path.iterdir():
                if file_path.is_file() and file_path.suffix in extensions:
                    all_files.append(file_path)
    
    # Sort files for consistent output
    all_files = sorted(all_files)
    
    print(f"Found {len(all_files)} source files")
    
    # Write consolidated file
    with open(output_file, 'w', encoding='utf-8') as f:
        # Write header
        f.write("# xsdmMle Package - Complete Source Code\n")
        f.write(f"# Generated on: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        f.write("# This file contains all R and C++ source code from the package\n")
        f.write("=" * 80 + "\n")
        f.write("\n")
        
        # Process each file
        for file_path in all_files:
            # Write file header
            f.write("=" * 80 + "\n")
            f.write(f"# FILE: {file_path}\n")
            f.write("=" * 80 + "\n")
            f.write("\n")
            
            # Read and write file contents
            try:
                with open(file_path, 'r', encoding='utf-8') as source_file:
                    contents = source_file.read()
                    f.write(contents)
                    # Ensure there's a newline at the end
                    if contents and not contents.endswith('\n'):
                        f.write('\n')
                    f.write("\n")
            except Exception as e:
                f.write(f"# ERROR reading file: {e}\n")
                f.write("\n")
        
        # Write footer
        f.write("=" * 80 + "\n")
        f.write("# End of consolidated source code\n")
        f.write(f"# Total files: {len(all_files)}\n")
    
    print(f"Code consolidation complete!")
    print(f"Output written to: {output_file}")
    print(f"Total files processed: {len(all_files)}")
    
    return output_file


if __name__ == "__main__":
    generate_code_text()
