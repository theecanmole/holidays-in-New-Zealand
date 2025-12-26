## New Zealand holidays and business days from the Python holidays package 1894 to 2030

To use the [Python holidays package](https://pypi.org/project/holidays/) to export New Zealand holidays to a CSV file on a Debian Linux OS, you need to first install the necessary packages, and then run a Python script to generate and save the data. 

Step 1: Install Python and Pip on a Debian/MX-23 operating system. 

Open your xterminal on the Debian system and run the following commands to ensure Python 3 and its package manager, pip, are installed. It is highly recommended to use a virtual environment to avoid system-wide package conflicts. 

1 Update package lists:
```    
sudo apt update
```
2 Install venv for virtual environments:
```
sudo apt install python3-venv -y
```
3 Create a new virtual environment (e.g., named nz_holidays_env):
```
python3 -m venv venv
```
4 Activate the virtual environment:
```
source venv/bin/activate
```
Your terminal prompt should change to show the active environment name (e.g., (nz_holidays_env)). 

Step 2: Install the holidays and pandas packages 
While the virtual environment is active, install the required Python packages using pip: 
```
pip install holidays pandas
```
Step 3: Create the Python script
Use a text editor (like nano or vim) to create a new Python script file, for example, generate_holidays.py. 
```
nano generate_holidays.py
```
Paste the following code into the file. This script uses the holidays package to get New Zealand holidays for a specified year range and the pandas library to export them to a CSV file

Python
```
import holidays
import pandas as pd
from datetime import date

def get_nz_holidays(years):
    """
    Retrieves New Zealand national holidays for a range of years.
    """
    nz_hols = holidays.NZ(years=years)
    holiday_list = []
    for date_obj, name in sorted(nz_hols.items()):
        holiday_list.append({'Date': date_obj, 'Holiday Name': name})
    return holiday_list

def save_to_csv(data, filename='new_zealand_holidays.csv'):
    """
    Saves the list of holidays to a CSV file using pandas.
    """
    df = pd.DataFrame(data)
    df.to_csv(filename, index=False)
    print(f"Successfully saved New Zealand holidays to {filename}")

if __name__ == "__main__":
    # Define the years you are interested in (e.g., 2024 to 2026)
    years_to_get = range(1894, 2027) 
    
    holidays_data = get_nz_holidays(years_to_get)
    save_to_csv(holidays_data)
```
Save and exit the editor (in nano, press Ctrl+O, then Enter, then Ctrl+X). 
Step 4: Run the script 
Execute the Python script from your terminal:
```
python generate_holidays.py
```
Step 5: Verify the CSV file 
The script will print a success message, and a file named new_zealand_holidays.csv will be created in your current directory. You can list the files to confirm its existence:
```
ls new_zealand_holidays.csv
```
You can view the contents of the CSV file using a command-line tool like  cat
```
cat new_zealand_holidays.csv
```
### CSV files

[new_zealand_holidays.csv](new_zealand_holidays.csv)

[holidaysanddaysofweek.csv[(holidaysanddaysofweek.csv)

[NZholidaysandotherdays1894_2026.csv](NZholidaysandotherdays1894_2026.csv)

[]()

### License

#### ODC-PDDL-1.0

This data and the R scripts are made available under the Public Domain Dedication and License v1.0 whose full text can be found at: http://www.opendatacommons.org/licenses/pddl/1.0/. You are free to share, to copy, distribute and use the data, to create or produce works from the data and to adapt, modify, transform and build upon the data, without restriction.
