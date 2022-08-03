import json
import getopt, sys

argumentList = sys.argv[1:]
is_valid_session_file = True
try:
    session_file = open(sys.argv[1])

    data = json.load(session_file)
    for token in ['accessKeyId', 'secretAccessKey', 'sessionToken']:
        if not token in data:
            print(f"\'{token}\' missing in session token file")
            is_valid_session_file = False

    if is_valid_session_file:
        print(f"export AWS_ACCESS_KEY_ID={data['accessKeyId']}")   
        print(f"export AWS_SECRET_ACCESS_KEY={data['secretAccessKey']}")
        print(f"export AWS_SESSION_TOKEN={data['sessionToken']}")
    else:
        print("Invalid session token file.")
        print("Usage:\n")
        print("python setup_creds.py <session_token_file>\n\n")

except:
    print("Invalid session token file.")
    print("Usage:")
    print("python setup_creds.py <session_token_file>\n\n")        
finally:
    session_file.close()
