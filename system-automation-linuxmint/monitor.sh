#!/bin/bash

echo "======================================"
echo "🖥️  Linux Mint System Monitoring Tool"
echo "======================================"
echo

# Function 1: Check disk space
check_disk() {
    echo "📦 Disk Usage:"
    df -h
    echo
}

# Function 2: Check memory usage
check_memory() {
    echo "🧠 Memory Usage:"
    free -h
    echo
}

# Function 3: Check for system updates
check_updates() {
    echo "🔄 Checking for system updates..."
    sudo apt update && sudo apt list --upgradable
    echo
}

# Function 4: List files modified in the last 24 hours
check_recent_files() {
    echo "🗂️  Files modified in the last 24 hours:"
    find ~/ -type f -mtime -1 2>/dev/null
    echo
}

# Function 5: Create a backup of tracked files with recent commits
create_backup() {
    BACKUP_DIR="backup"
    echo "🔒 Checking for backup folder..."
    
    # Check if backup directory exists, if not, create it
    if [ ! -d "$BACKUP_DIR" ]; then
        mkdir "$BACKUP_DIR"
        echo "Backup folder created at: $(pwd)/$BACKUP_DIR"
    else
        echo "Backup folder already exists at: $(pwd)/$BACKUP_DIR"
    fi
    echo
    
    changes_made=false

    # Loop through tracked files in the repo
    for file in $(git ls-files); do
        if [[ "$file" == "$BACKUP_DIR"* ]]; then
            continue
        fi
        [ -f "$file" ] || continue

        # Get the commit time of the file
        commit_time=$(git log -1 --format="%ct" -- "$file")
        backup_file="$BACKUP_DIR/$file"
        
        # If backup doesn't exist, create a new backup
        if [ ! -f "$backup_file" ]; then
            mkdir -p "$(dirname "$backup_file")"
            cp "$file" "$backup_file"
            echo "Backed up new file: $file"
            changes_made=true
        else
            backup_time=$(stat -c %Y "$backup_file")

            # If the file was updated, overwrite the backup
            if [ "$commit_time" -gt "$backup_time" ]; then
                cp "$file" "$backup_file"
                echo "Updated backup: $file"
                changes_made=true
            fi
        fi
    done

    # If no changes were made
    if [ "$changes_made" = false ]; then
        echo "No recent file changes."
    fi
    echo
}

# Main script: Check for which function to run based on the argument
case "$1" in
    "disk")
        check_disk
        ;;
    "memory")
        check_memory
        ;;
    "updates")
        check_updates
        ;;
    "recent-files")
        check_recent_files
        ;;
    "backup")
        create_backup
        ;;
    *)
        echo "Usage: $0 {disk|memory|updates|recent-files|backup}"
        echo "  disk        - Check disk space"
        echo "  memory      - Check memory usage"
        echo "  updates     - Check system updates"
        echo "  recent-files - List files modified in the last 24 hours"
        echo "  backup      - Create a backup of recent tracked files"
        ;;
esac
