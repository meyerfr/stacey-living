require 'bundler'
Bundler.require

# Authenticate a session with your Service Account
session = GoogleDrive::Session.from_service_account_key("user_secret.json")
# Get the spreadsheet by its title
spreadsheet = session.spreadsheet_by_title("STACEY Users")
# Get the first worksheet
worksheet = spreadsheet.worksheets.first

# Print out the first 6 columns of each row

