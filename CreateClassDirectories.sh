#!/bin/bash

# # --- Config ---
DONE="done"
SEMESTERS=("Spring" "Summer" "Fall")

# get the name of the directory
read -r -p "Enter the year: " YEAR

# YEAR=$(date +%Y)
ROOT_DIR="$YEAR"

echo "Course directories will be added for $ROOT_DIR"

# --- set the umask to 0000 for full control
ORIGINAL_UMASK_VALUE=$(umask) # this will be used to reset the permissions at the end
# setting umask to full control so we can create directories below the root
umask 0000

# --- Set up the directory structure
echo "Setting up the directory structure..."

# create the directory for the year
read -r -p "Enter the path to the root directory: " ROOT_PATH
echo $ROOT_PATH
mkdir -p "$ROOT_DIR" || { echo "Error: Could not create main directory $ROOT_DIR. Exiting.", exit 1; }

# create the semester directories
for semester in "${SEMESTERS[@]}"; do
	mkdir -p "$ROOT_DIR/$semester"
done

echo "Base directories created: $ROOT_DIR/{Spring Summer Fall}"

# --- 2. Select the semester to add class folders ---
echo 
echo "Select a semester to add classes?"

PS3='Please select a season number: ' # PS3 is the prompt for the select command

select selected_semester in "${SEMESTERS[@]}"; do
	if [[ " ${SEMESTERS[@]} " =~ " ${selected_semester}" ]]; then 
		# semester is valid
		
		TARGET_DIR="$ROOT_PATH/$ROOT_DIR/$selected_semester"
		echo "You have selected the **$selected_semester** directory, in the $ROOT_DIR folder"
		break
	else
		# semester is invalid
		echo "Invalid selection. Please enter a number between 1 and ${#SEMESTERS[@]}."
	fi
done

# --- 3. Create the directories for the selected semester ---

echo
echo "Enter the names of the courses you will be teaching."
echo "Type **done** when all courses have been added"

while true; do
	read -r -p "Enter the directory name (or '$DONE' to exit): " DIR_NAME
	echo "The directory name is $DIR_NAME"

	# if the user entered the exit value, exit the script
	if [ "$DIR_NAME" == "$DONE" ]; then
		echo "Exit command received. Finishing up and exiting script."
		break
	fi


	if [[ -z "$DIR_NAME" || "$DIR_NAME" =~ ^[[:space:]]+$ ]]; then
		echo "Directory name cannot be empty. Try again."
		continue
	fi

	#create the directories
	echo "Creating $TARGET_DIR"
	mkdir -p "$TARGET_DIR/$DIR_NAME"
	if [ $? -eq 0 ]; then
		echo "$TARGET_DIR/$DIR_NAME created."
		echo "Adding Assignments and InClass directories."


		mkdir -p "$TARGET_DIR/$DIR_NAME/assignments"
		if [$? -eq 0]; then
			echo "Added assignments directory."
		else 
			echo "assignments directory not created!"
		fi
		mkdir -p "$TARGET_DIR/$DIR_NAME/in_class"
		if [ $? -eq 0]; then
			echo "Added in_class directory."
		else 
			echo "in_class directory not created!"
		fi
	echo "Error creating directory: $DIR_NAME"
	fi
done

echo 
echo "Resetting umask ..."
umask $ORIGINAL_UMASK_VALUE
echo 
echo "✅ Script execution complete."