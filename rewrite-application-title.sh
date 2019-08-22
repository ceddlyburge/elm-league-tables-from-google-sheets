if [ -z "$ELM_APP_APPLICATION_TITLE" ]
then
	echo "ELM_APP_APPLICATION_TITLE environment variable not defined, using default application title"
else
	sed -i "s/<title>League Tables/<title>$ELM_APP_APPLICATION_TITLE/g" public/index.html
	sed -i "s/League Tables/$ELM_APP_APPLICATION_TITLE/g" public/manifest.json
fi
