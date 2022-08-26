from email.mime.text import MIMEText
from email.mime.image import MIMEImage
from email.mime.application import MIMEApplication
from email.mime.multipart import MIMEMultipart
import smtplib
import os
import sys


def main():
    sendEmail(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4])

def sendEmail(to, subject, body, img=None):
    smtp = smtplib.SMTP("smtp.gmail.com", 587)
    smtp.ehlo()
    smtp.starttls()
    smtp.login("michael.krzyzanowski.11@gmail.com", "aazetchyjekoviqf")
    
    msg = message(subject, body, img)
    
    smtp.sendmail(from_addr = "michael.krzyzanowski.11@gmail.com", to_addrs = to, msg = msg.as_string())
    smtp.quit()

def message(subject = "", text = "", img = None):
    msg = MIMEMultipart()
    msg['subject'] = subject
    msg.attach(MIMEText(text))
    
    # attaching images to the email
    if img is not None:
        imgData = open(img, "rb").read()
        
    msg.attach(MIMEImage(imgData, name=os.path.basename(img)))
    
    return msg

if __name__ == "__main__":
    main()
