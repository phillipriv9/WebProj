##First step of WorkflowR tutorial

#Publishing Initial Files
wflow_publish(c("analysis/index.Rmd", "analysis/about.Rmd", "analysis/license.Rmd"), "Publishing the initial files for my website")

#Troubleshooting
#Was Parathesises issue

# Example file path
file_path <- "analysis/index.Rmd"

# Check if the file path exists
if (file.exists(file_path)) {
  print("File exists!")
} else {
  print("File does not exist.")
}

#Checks Status of Project
wflow_status()

#Telling it to use my GitHub account adn to make the repsoitory there
wflow_use_github("phillipriv9")

#Pushing Current Progress
#Making dry run true gives us a preview of what the function will do. A good way to check things prior to actually pushing.
wflow_git_push(dry_run = TRUE)

#Actual Push
wflow_git_push()

#Opening a new analysis file
wflow_open("analysis/first-analysis.Rmd")

#Publish changes
wflow_publish("analysis/first-analysis.Rmd")

#Opening Index
wflow_open("analysis/index.Rmd")

#Running a Status check
wflow_status()

#Publishing new stuff
wflow_publish(c("analysis/index.Rmd", "analysis/first-analysis.Rmd"),
              "Update Ananlysis")

#Pushing the files
wflow_git_push()


