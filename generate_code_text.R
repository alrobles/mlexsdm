#!/usr/bin/env Rscript
# Script to consolidate all source code into a single plain text file
# This makes it easy to share the entire codebase

# Function to consolidate all source code files
generate_code_text <- function(output_file = "all_code.txt") {
  # Define directories to scan for code
  code_dirs <- c("R", "src")
  
  # File extensions to include
  extensions <- c(".R", ".cpp", ".h")
  
  # Open output file
  con <- file(output_file, "w")
  
  # Write header
  writeLines("# xsdmMle Package - Complete Source Code", con)
  writeLines(paste("# Generated on:", Sys.time()), con)
  writeLines("# This file contains all R and C++ source code from the package", con)
  writeLines(paste(rep("=", 80), collapse = ""), con)
  writeLines("", con)
  
  # Collect all files
  all_files <- c()
  for (dir in code_dirs) {
    if (dir.exists(dir)) {
      files_in_dir <- list.files(dir, full.names = TRUE, recursive = FALSE)
      # Filter by extension
      for (ext in extensions) {
        all_files <- c(all_files, files_in_dir[grepl(paste0("\\", ext, "$"), files_in_dir)])
      }
    }
  }
  
  # Sort files for consistent output
  all_files <- sort(unique(all_files))
  
  cat("Found", length(all_files), "source files\n")
  
  # Process each file
  for (file_path in all_files) {
    # Write file header
    writeLines(paste(rep("=", 80), collapse = ""), con)
    writeLines(paste("# FILE:", file_path), con)
    writeLines(paste(rep("=", 80), collapse = ""), con)
    writeLines("", con)
    
    # Read and write file contents
    tryCatch({
      file_contents <- readLines(file_path, warn = FALSE)
      writeLines(file_contents, con)
      writeLines("", con)
      writeLines("", con)
    }, error = function(e) {
      writeLines(paste("# ERROR reading file:", e$message), con)
      writeLines("", con)
    })
  }
  
  # Write footer
  writeLines(paste(rep("=", 80), collapse = ""), con)
  writeLines("# End of consolidated source code", con)
  writeLines(paste("# Total files:", length(all_files)), con)
  
  close(con)
  
  cat("Code consolidation complete!\n")
  cat("Output written to:", output_file, "\n")
  cat("Total files processed:", length(all_files), "\n")
  
  invisible(output_file)
}

# Run if executed as script
if (!interactive()) {
  generate_code_text()
}
