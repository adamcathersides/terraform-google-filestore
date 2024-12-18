import google.auth
import google.auth.transport.requests
from google.auth.transport.requests import AuthorizedSession
import time
import requests
import json
import os

PROJECT_ID = os.environ.get("PROJECT_ID")
INSTANCE_LOCATION = os.environ.get("INSTANCE_LOCATION")
INSTANCE_NAME = os.environ.get("INSTANCE_NAME")
INSTANCE_FILE_SHARE_NAME = os.environ.get("INSTANCE_FILE_SHARE_NAME")
BACKUP_REGION = os.environ.get("BACKUP_REGION")

credentials, project = google.auth.default()
request = google.auth.transport.requests.Request()
credentials.refresh(request)
authed_session = AuthorizedSession(credentials)

def get_backup_id():
    return INSTANCE_NAME + '-' + time.strftime("%Y%m%d-%H%M%S")

def create_backup(request):
    trigger_run_url = "https://file.googleapis.com/v1/projects/{}/locations/{}/backups?backupId={}".format(PROJECT_ID, BACKUP_REGION, get_backup_id())
    headers = {
      'Content-Type': 'application/json'
    }
    post_data = {
      "description": "Filestore auto backup managed by Cloud Run Function",
      "source_instance": "projects/{}/locations/{}/instances/{}".format(PROJECT_ID, INSTANCE_LOCATION, INSTANCE_NAME),
      "source_file_share": "{}".format(INSTANCE_FILE_SHARE_NAME)
    }
    print("Making a request to " + trigger_run_url)
    r = authed_session.post(url=trigger_run_url, headers=headers, data=json.dumps(post_data))
    data = r.json()
    print(data)
    if r.status_code == requests.codes.ok:
      print(str(r.status_code) + ": The backup is uploading in the background.")
    else:
      raise RuntimeError(data['error'])
    return "Backup creation has begun!"
