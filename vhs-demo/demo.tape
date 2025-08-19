# Claucker Complete Demo
# Run this from a clean directory (e.g., mkdir vhs-demo && cd vhs-demo)
Output demo-complete.gif
Set FontSize 24
Set Width 1080
Set Height 1080
Set Theme "Dracula"
Set Padding 25
Set TypingSpeed 45ms

# Title
Type "# Claucker: Safe Containerized Claude Code"
Enter
Sleep 3s

Type "# Use --dangerously-skip-permissions but with isolation from your system!"
Enter
Sleep 3s

Type "# Only your current working directory is visible..."
Enter
Sleep 3s

Type "clear"
Sleep 1s
Enter

# Download claucker
Type "# Step 1: Download claucker"
Enter
Sleep 2s
Type "curl -O https://raw.githubusercontent.com/dnouri/claucker/master/claucker"
Enter
Sleep 3s
Type "chmod +x claucker"
Enter
Sleep 2s

Type "clear"
Sleep 1s
Enter

# Interactive mode demo
Type "# Step 2: Run claucker to drop into claude session"
Enter
Sleep 2s
Type "./claucker"
Sleep 2s
Enter
# Wait for container and REPL to start
Sleep 3s

# Create a file
Type "Create a simple hello.py that prints 'Hello from Claude in Docker!'"
Enter
# Give Claude time to create the file
Sleep 10s

# Exit REPL
Type "/exit"
Sleep 2s
Enter
Sleep 2s

# Check created file
Type ""
Enter
Type "# Check what Claude created:"
Enter
Type "cat hello.py"
Sleep 2s
Enter
Sleep 5s

Type "python3 hello.py"
Enter
Sleep 2s

Type "clear"
Sleep 1s
Enter

# Resume session demo
Type "# Step 3: Resume previous session"
Enter
Sleep 2s
Type "# Claude remembers your context!"
Enter
Sleep 2s
Type "./claucker --resume"
Sleep 6s
Enter
Sleep 2s
Enter

Type "Now add a function to hello.py that returns the current time"
Enter
# Give Claude time to modify the file
Sleep 12s

Type "/exit"
Sleep 1s
Enter
Sleep 2s

Type "clear"
Sleep 1s
Enter
Type "cat hello.py"
Enter
Sleep 3s

Type "clear"
Sleep 1s
Enter

Type "# More command line arguments and a config allow for finer control"
Enter
Sleep 1s
Type "claucker --help"
Enter
Sleep 8s
Type "clear"
Sleep 1s

# Show containerization
Type "# Step 4: Everything runs in Docker!"
Enter
Sleep 2s
Type "# --debug allows us to enter bash within the container"
Enter
Sleep 2s
Type "claucker --debug"
Enter
Sleep 1s
Type "ls /home/ubuntu/ -lah"
Enter
Sleep 5s
Type "exit"
Sleep 1s

Type ""
Enter
Type "# Claude runs isolated in a container"
Enter
Type "# Your system stays protected"
Enter
Type "# Only this directory is mounted"
Enter
Sleep 4s

Type "clear"
Sleep 1s
Enter

# Key features summary
Type "# Key Features:"
Enter
Sleep 2s
Type "echo '✓ Non-interactive mode:  -p flag for quick queries'"
Enter
Sleep 1s
Type "echo '✓ Interactive REPL:      Full Claude interface'"
Enter
Sleep 1s
Type "echo '✓ Session resumption:    --resume to continue'"
Enter
Sleep 1s
Type "echo '✓ Container isolation:   Docker keeps you safe'"
Enter
Sleep 1s
Type "echo '✓ Permission control:    --no-yolo for cautious mode'"
Enter
Sleep 3s

Type ""
Enter
Type "# github.com/dnouri/claucker"
Enter
Sleep 5s
