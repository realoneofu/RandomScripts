from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from bs4 import BeautifulSoup
import re
from datetime import datetime

startTime = datetime.now()
carTotal = 0

# define options
options = Options()
options.headless = True
options.add_argument("--window-size=1920,1200")

# get data from website
driver = webdriver.Chrome(options=options)
driver.get(
    "https://www.auto24.ee/kasutatud/nimekiri.php?bn=2&a=100&aj=&ae=8&af=50&otsi=otsi+%2829268%29"
)
container = driver.find_element(By.ID, "usedVehiclesSearchResult-flex")
car = container.find_elements(By.CLASS_NAME, "description")

# main code

data = {}

for info in car:
    # get the columns
    try:
        model = info.find_element(By.CLASS_NAME, "model").text
    except:
        model = "No Info Provided"
        pass
    try:
        engine = info.find_element(By.CLASS_NAME, "engine").text
    except:
        engine = "No Info Provided"
        pass
    try:
        year = info.find_element(By.CLASS_NAME, "year").text
    except:
        year = "No Info Provided"
        pass
    try:
        mileage = re.sub("\D", "", info.find_element(By.CLASS_NAME, "mileage").text)
    except:
        mileage = "No Info Provided"
        pass
    try:
        price = re.sub("\D", "", info.find_element(By.CLASS_NAME, "price").text)
    except:
        price = "No Info Provided"
        pass
    try:
        fuel = info.find_element(By.CLASS_NAME, "fuel sm-none").text
    except:
        fuel = "No Info Provided"
        pass
    try:
        transm = info.find_element(By.CLASS_NAME, "transmission sm-none").text
    except:
        transm = "No Info Provided"
        pass
    try:
        body = info.find_element(By.CLASS_NAME, "bodytype").text
    except:
        body = "No Info Provided"
        pass
    try:
        drive = info.find_element(By.CLASS_NAME, "drive").text
    except:
        drive = "No Info Provided"
        pass
    carTotal += 1
    print("------")
    print(
        f"Model: {model}\nEngine: {engine}\nYear: {year}\nMileage: {mileage}\nPrice: {price}\nFuel: {fuel}\nTransmission: {transm}\nBody: {body}\nDrive: {drive}"
    )

print("------\n")
print("---Info---")
print("Data scraping finished!")
print("---Statistics---")
print("Total of cars collected: ", carTotal)
print("Time taken: ", datetime.now() - startTime)
driver.quit()
