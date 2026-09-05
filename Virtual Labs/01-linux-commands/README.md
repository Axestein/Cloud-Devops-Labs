# VLE 01 — Linux Commands

**Author:** Aditya Kumar Singh

This lab report covers two related practicals under **Unit 2**: basic Linux command-line operations (Practice 5) and scenario-based exercises combining AWS CLI configuration with file manipulation, redirection, `grep`, `cut`, `awk`, and command chaining (VLE 2).

## Objective
- Practice fundamental Linux file manipulation and shell commands
- Understand redirection operators and standard streams (STDIN/STDOUT/STDERR)
- Use `grep`, `cut`, and `awk` for text filtering and field extraction
- Chain commands together using pipes for multi-step data processing
- Configure and verify the AWS CLI on a Linux (WSL/Ubuntu) environment

---

## Part 1 — Practice 5: Basic Linux Commands

### 1. File Manipulation
```bash
pwd
ls
mkdir UNIT2_LAB
cd UNIT2_LAB
touch data.txt
cat data.txt
```

### 2. Redirection Operators
```bash
echo "This is some sample data" >> data.txt   # append
echo "This is some sample data" > data.txt    # overwrite
ls > filelist.txt                             # redirect ls output to a file
```

### 3. Standard Streams (STDIN, STDOUT, STDERR)
- **STDIN** — normal input source for a program (usually the keyboard)
- **STDOUT** — normal output channel (usually the terminal), e.g. `echo "Hello Ubuntu"`
- **STDERR** — error/warning channel, e.g. `cat abc.txt` → `cat: abc.txt: No such file or directory`

### 4. Grep Command
```bash
grep "data" data.txt
grep -v "data" data.txt
grep "data" data.txt | grep "sample"
```

### 5. Cut Command
```bash
cut -d" " -f2 data.txt
cut -c 1-5 data.txt
```

### 6. Awk Command
```bash
awk '{print $2}' data.txt
awk 'END {print NR}' data.txt
```

### 7. Command Chaining
```bash
grep "data" data.txt | cut -d" " -f2 | awk '{print substr($1,1,3)}'
```

---

## Part 2 — VLE 2: AWS CLI Setup & Scenario-Based Exercises

### AWS CLI Configuration & Verification
```bash
aws --version
aws configure          # entered temporary Access Key, Secret Key, Session Token, region (us-east-1), output (json)
aws sts get-caller-identity
aws configure list
```
Confirmed the assumed-role identity (`voclabs/user5276813=Aditya_Kumar_Singh`) and that credentials were loaded from the shared credentials file.

### Scenario 1 — Student Records Folder Setup
```bash
mkdir -p IT-Lab-03/Sem-6
cd IT-Lab-03/Sem-6
touch records.txt
cat records.txt   # verified empty
```

### Scenario 2 — Appending Results from Terminal
```bash
echo "RegNo: 1023 | Name: Arjun | Grade: A" >> records.txt
echo "RegNo: 1024 | Name: Ravi | Grade: B" > records.txt
ls -la > filelist.txt
```

### Scenario 3 — Debugging Execution Logs (STDIN, STDOUT, STDERR)
| Stream | Meaning | Example |
|---|---|---|
| STDIN | Standard Input — normal input source, usually the keyboard | `cat > input.txt` |
| STDOUT | Standard Output — normal output, usually the terminal | `echo "This is normal output (STDOUT)"` |
| STDERR | Standard Error — error/warning messages | `invalid_command_xyz` → `command not found` |

### Scenario 4 — Searching Inside Text with grep
```bash
grep "Grade" records.txt
grep -v "A" records.txt
grep "Grade" records.txt | grep "B"
```

### Scenario 5 — Extracting Specific Fields using cut
```bash
cut -d" " -f2 records.txt
cut -c 1-5 records.txt
```

### Scenario 6 — Working with Fields using awk
```bash
awk -F'|' '{print $3}' records.txt      # Grade field
awk 'END {print NR}' records.txt        # total line count
```

### Scenario 7 — Data Pipeline Automation (Command Chaining)
Extracted the first 3 characters of names for students with Grade A:
```bash
grep "Grade: A" records.txt | cut -d "|" -f2 | awk '{print substr($2,1,3)}'
```

## Contents of this Directory
| File | Description |
|---|---|
| `VLE-01-Linux-Commands.pdf` | Completed lab report — Practice 5 terminal session + VLE 2 AWS CLI setup and scenario exercises |
| `Practices5.pdf` | Reference instructions for Practice 5 (basic file manipulation, redirection, streams, grep, cut, awk, chaining) |
| `VLE-2_Linux.pdf` | Reference instructions for the VLE 2 scenario-based exercises |
| `README.md` | This file |

## Outcome
Practiced core Linux file and text-processing commands, understood the three standard I/O streams, and combined `grep`, `cut`, and `awk` via pipes to solve multi-step data-extraction tasks. Also configured and verified AWS CLI access using temporary session credentials on a Linux/WSL environment.