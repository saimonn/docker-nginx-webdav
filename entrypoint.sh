#!/bin/bash

if [[ -n "$USERNAME_FILE" ]] && [[ -n "$PASSWORD_FILE" ]]
then
  echo "Using user+password files $USERNAME_FILE"
  USERNAME=$(cat "$USERNAME_FILE")
  PASSWORD=$(cat "$PASSWORD_FILE")
fi

if [[ -n "$USERNAME" ]] && [[ -n "$PASSWORD" ]]
then
  echo "Setting credentials for user '$USERNAME'"
	htpasswd -bc /etc/nginx/htpasswd "$USERNAME" "$PASSWORD"
else
  if [ -r /etc/nginx/htpasswd ];then
    echo "Using provided /etc/nginx/htpasswd with checksum $(sha256sum /etc/nginx/htpasswd)"
  else
    echo "No htpasswd nor USERNAME/PASSWORD env provided: disabling basic_auth."
	  sed -i 's%auth_basic "Restricted";% %g' /etc/nginx/conf.d/default.conf
	  sed -i 's%auth_basic_user_file /etc/nginx/htpasswd;% %g' /etc/nginx/conf.d/default.conf
  fi
fi

echo "Starting nginx"
exec /usr/bin/nginx -g "daemon off;"
