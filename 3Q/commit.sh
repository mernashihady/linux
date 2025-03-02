

BUGID="234"
DESCRIPTION="File name should contain date in header"
BRANCH="br_1"
DEVELOPER="g.cohen"
PRIORITY="3"
REPO_PATH="./REPO1"

CURR_DATE=$(date "+%Y-%m-%d %H:%M:%S")

CSV_FILE="data_$(date '+%Y%m%d').csv"

if [ ! -f "$CSV_FILE" ]; then
    echo "Error: CSV file $CSV_FILE not found!"
    exit 1
fi

DUMMY_FILE="dummy_file.txt"
echo "This is a test file for commit." > $DUMMY_FILE

git branch | grep -w $BRANCH > /dev/null 2>&1
if [ $? -ne 0 ]; then
    git checkout -b $BRANCH
else
    git checkout $BRANCH
fi

git add $CSV_FILE $DUMMY_FILE

COMMIT_MESSAGE="$BUGID:$CURR_DATE:$BRANCH:$DEVELOPER:$PRIORITY:Excel Description"
git commit -m "$COMMIT_MESSAGE"
if [ $? -ne 0 ]; then
    echo "Error: Commit failed!"
    exit 1
fi

git log --pretty=format:"%h - %an, %ar : %s" > ~/Work_Course_Linux/3Q/commits.txt

git push origin $BRANCH
if [ $? -ne 0 ]; then
    echo "Error: Push to GitHub failed!"
    exit 1
fi

echo "Commit successful! Commit message saved to commits.txt"


