if [ $# -eq 0 ]
  then
    echo "No arguments supplied."
    echo "Usage:"
    echo "demo_setup <oidc_session_token_file>"
fi
cat utils/install_latest.sh > run1.sh
echo "" >> run1.sh
echo "echo \"Setting up AWS credentials...\"" >> run1.sh
python utils/setup_creds.py $1 >> run1.sh
echo "echo \"Setup of AWS credentials...Done\"" >> run1.sh
echo "export CLOUDFIX_FILE=true" >> run1.sh
chmod 755 run1.sh

