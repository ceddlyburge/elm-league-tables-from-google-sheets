if [ -z "$ELM_APP_APPLICATION_ICON" ]
then
	echo "ELM_APP_APPLICATION_ICON environment variable not defined, using default application icon"
else
	curl -o public/favicon.png $ELM_APP_APPLICATION_ICON
fi
