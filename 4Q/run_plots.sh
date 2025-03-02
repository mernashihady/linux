#!/bin/bash


if [ $# -ne 1 ]; then
    echo " Error: No CSV file provided."
    echo "Usage: $0 <csv_file_path>"
    exit 1
fi

CSV_FILE="$1"


if [ ! -f "$CSV_FILE" ]; then
    echo " Error: The file $CSV_FILE does not exist."
    exit 1
fi


LOG_FILE="$HOME/Work_Course_Linux/4Q/run_plots.log"
touch "$LOG_FILE"
chmod 666 "$LOG_FILE"  # Ensure the file has correct write permissions
echo " Script started at $(date)" > "$LOG_FILE"


VENV_PATH="$HOME/plant_env"

if [ ! -d "$VENV_PATH" ]; then
    echo " Creating virtual environment at: $VENV_PATH" | tee -a "$LOG_FILE"
    python3 -m venv "$VENV_PATH"
fi

source "$VENV_PATH/bin/activate"


pip list | grep -q numpy || pip install numpy matplotlib >> "$LOG_FILE" 2>&1


tail -n +2 "$CSV_FILE" | while IFS=, read -r plant height leaf_count dry_weight
do
    
    plant=$(echo "$plant" | tr -d '"')
    height=$(echo "$height" | tr -d '"')
    leaf_count=$(echo "$leaf_count" | tr -d '"')
    dry_weight=$(echo "$dry_weight" | tr -d '"')

    echo " Processing data for plant: $plant" | tee -a "$LOG_FILE"

    
    PLANT_DIR="$HOME/Work_Course_Linux/4Q/$plant"
    mkdir -p "$PLANT_DIR"

    
    python ~/Work_Course_Linux/4Q/plant_plots.py --plant "$plant" --height $height --leaf_count $leaf_count --dry_weight $dry_weight >> "$LOG_FILE" 2>&1

    
    if [ $? -eq 0 ]; then
        echo " Successfully generated plots for $plant!" | tee -a "$LOG_FILE"

       
        mv ~/Work_Course_Linux/4Q/${plant}_*.png "$PLANT_DIR/"
    else
        echo " Error: Failed to generate plots for $plant" | tee -a "$LOG_FILE"
    fi
done

echo " Script execution completed successfully at $(date)" | tee -a "$LOG_FILE"

