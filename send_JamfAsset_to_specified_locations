from fastapi import FastAPI, HTTPException
import csv
import requests
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
from datetime import datetime, timedelta
import threading

app = FastAPI()

# Define the Jamf API endpoint and authentication details
JAMF_API_ENDPOINT = "https://your-jamf-instance.jamfcloud.com/JSSResource/computers"
USERNAME = "your_username"
PASSWORD = "your_password"

# Define email details
SMTP_SERVER = "smtp.your-email-provider.com"
SMTP_PORT = 587
EMAIL_ADDRESS = "your_email@example.com"
EMAIL_PASSWORD = "your_email_password"
RECIPIENTS = ["recipient1@example.com", "recipient2@example.com"]

def collect_assets():
    try:
        # Make a request to the Jamf API to get computer assets
        response = requests.get(JAMF_API_ENDPOINT, auth=(USERNAME, PASSWORD))
        response.raise_for_status()
        
        # Parse the JSON response
        computers = response.json()["computers"]
        
        # Define the CSV file name
        csv_file = "jamf_computer_assets.csv"
        
        # Write the computer assets to a CSV file
        with open(csv_file, mode='w', newline='') as file:
            writer = csv.writer(file)
            # Write the header row
            writer.writerow(["ID", "Name", "Model", "Serial Number", "MAC Address"])
            # Write the computer asset rows
            for computer in computers:
                writer.writerow([
                    computer["id"],
                    computer["name"],
                    computer["model"],
                    computer["serial_number"],
                    computer["mac_address"]
                ])
        
        return csv_file
    
    except requests.exceptions.RequestException as e:
        raise HTTPException(status_code=500, detail=str(e))

def send_email(csv_file):
    try:
        # Create a multipart message
        msg = MIMEMultipart()
        msg['From'] = EMAIL_ADDRESS
        msg['To'] = ", ".join(RECIPIENTS)
        msg['Subject'] = "Daily Jamf Computer Assets Report"
        
        # Attach the body with the msg instance
        body = "Please find attached the daily Jamf computer assets report."
        msg.attach(MIMEText(body, 'plain'))
        
        # Open the file to be sent
        attachment = open(csv_file, "rb")
        
        # Instance of MIMEBase and named as p
        part = MIMEBase('application', 'octet-stream')
        
        # To change the payload into encoded form
        part.set_payload((attachment).read())
        
        # Encode into base64
        encoders.encode_base64(part)
        
        part.add_header('Content-Disposition', f"attachment; filename= {csv_file}")
        
        # Attach the instance 'part' to instance 'msg'
        msg.attach(part)
        
        # Create SMTP session for sending the mail
        server = smtplib.SMTP(SMTP_SERVER, SMTP_PORT)
        server.starttls()
        
        # Login to the server
        server.login(EMAIL_ADDRESS, EMAIL_PASSWORD)
        
        # Convert the Multipart msg into a string
        text = msg.as_string()
        
        # Send the mail
        server.sendmail(EMAIL_ADDRESS, RECIPIENTS, text)
        
        # Terminate the SMTP session and close the connection
        server.quit()
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

def job():
    csv_file = collect_assets()
    send_email(csv_file)

def schedule_daily_job():
    while True:
        now = datetime.now()
        next_run_time = now.replace(hour=8, minute=0, second=0, microsecond=0)
        
        if now >= next_run_time:
            next_run_time += timedelta(days=1)
        
        sleep_time = (next_run_time - now).total_seconds()
        
        threading.Timer(sleep_time, job).start()

@app.on_event("startup")
async def startup_event():
    threading.Thread(target=schedule_daily_job).start()

@app.get("/collect_assets")
def collect_assets_endpoint():
    csv_file = collect_assets()
    send_email(csv_file)
    return {"message": f"Computer assets have been collected and saved to {csv_file}, and emailed to recipients."}

# Run the FastAPI app using uvicorn
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
