-- Example "WideWorldImporters: Website.ActivateWebsiteLogon denies the logon activation for PersonID == 1"
-- ./spec/website/activateWebsiteLogon.rb:11
-- Executed at 2017-08-16 17:41:54 -0700

-- Initiate the example script
begin transaction;

-- Set default options
set textsize 2147483647;
set language us_english;
set dateformat mdy;
set datefirst 7;
set lock_timeout -1;
set quoted_identifier on;
set arithabort on;
set ansi_null_dflt_on on;
set ansi_warnings on;
set ansi_padding on;
set ansi_nulls on;
set concat_null_yields_null on;


-- query '/WideWorldImporters/website/activateLogon.sql.erb', options = {:PersonID=>1, :LogonName=>"testuser@wideworldimporters.com", :Password=>"Yukon900"}
exec Website.ActivateWebsiteLogon @PersonID = '1', @LogonName = 'testuser@wideworldimporters.com', @InitialPassword = 'Yukon900'

select LogonName 
from Application.People
where PersonID = '1' and LogonName = 'testuser@wideworldimporters.com'

-- Rollback the changes made by the example script
if @@trancount > 0 rollback transaction;

--               SLACKER RESULTS
-- *******************************************
-- Failure/Error:
--   expect{
--       sql.WideWorldImporters.website.activateLogon(
--           :PersonID => 1, 
--           :LogonName => 'testuser@wideworldimporters.com', 
--           :Password => 'Yukon900')}
--       .to raise_error(TinyTds::Error, 'Invalid PersonID')
-- 
--   expected TinyTds::Error with "Invalid PersonID", got #<TinyTds::Error: Could not find stored procedure 'Website.ActivateWebsiteLogon'.> with backtrace:
--     # ./spec/website/activateWebsiteLogon.rb:13:in `block (3 levels) in <top (required)>'
--     # ./spec/website/activateWebsiteLogon.rb:12:in `block (2 levels) in <top (required)>'
-- ./spec/website/activateWebsiteLogon.rb:12:in `block (2 levels) in <top (required)>'
-- *******************************************