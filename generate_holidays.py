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
