#MailChimp Adjuster

Assumptions:  

  -  Interest Grouping named 'Classes' exists
  -  Interest Grouping named 'Class Locations' exists
  -  Member has a merge value 'CLASS'
  -  Member has a merge value 'CLASSLOC'

The script will:  

  -  Evaluates all MailChimp members merge values for class and location
  -  Finds the class and location group based on the given member value
  -  Creates the class and location group if the group does not exist
  -  Updates the member group interest to true

To run the program:  
`$ bundle install`  
`$ ruby mail_adjuster.rb`  

Required environment variables:  

  -  MAILCHIMP_KEY
  -  MAILCHIMP_LIST

Constants to be set (in lib/mail_chimp.rb):  

  -  CLASS_ID
  -  CLASS_NAME
  -  LOCATION_ID
  -  LOCATION_NAME
