# AI Agent Guidelines for NCCU-NSYSU-Courses

This repository documents university courses from NCCU (Bachelor's) and NSYSU (Master's) programs.

## Course Markdown Format Convention

### Structure

Each course markdown file follows this standard structure:

```
# Course Title

## Course Details
- Type of Credit: [...]
- Credits: [...]
- Course Department: [...]
- Instructor: [...]
- Prerequisites: [...]
- Session: [...]

## Course Description
[Description of course content and objectives]

## Course Schedule & Requirements
[Schedule table - see below]
```

### Schedule & Requirements Table

The `Course Schedule & Requirements` section **must be a markdown table**. The table structure varies by course type but commonly includes:

- **By Date**: For courses with irregular schedules (e.g., [ComputerProgramming1](Courses/Semester1/ComputerProgramming1/ComputerProgramming1.md))
  - Columns: `Date | Topics`

- **By Week**: For structured semester courses (e.g., [DataStructures](Courses/Semester3/DataStructures/DataStructures.md))
  - Columns: `Week | Topic | Content and Reading Assignment | Teaching Activities and Homework | In-class Hours | Outside-of-class Hours`

When editing or creating course files:
- **Always use markdown table format** for Course Schedule & Requirements
- **Do not use bullet points or plain text** for schedules
- Adapt the table structure to the course's specific needs (dates vs. weeks, relevant columns)
- **Only edit based on existing content** — do not fabricate or add information that doesn't exist in the page
- Preserve all original data; only reformat or structure existing information into tables

## Key Directories

- `Courses/Semester1-9/` — Course notes organized by semester and subject
- `Images/` — University logos and images

## Common Patterns

- Bilingual headers: English names followed by Chinese translations (e.g., "Computer Programming 1 | 計算機程式設計(一)")
- Course codes in `Course Department` field (e.g., "Computer Science/B/1")
- Session format: `day+time` (e.g., "wed09-12" for Wednesday 9am-12pm)
