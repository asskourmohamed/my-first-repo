#!/bin/bash
PASSWORD="ton_mot_de_passe_ici"
for port in {31000..32000}; do
  echo "Testing port $port..."
  result=$(echo "$PASSWORD" | timeout 3 openssl s_client -connect localhost:$port 2>/dev/null | tail -n 10)
  if [[ "$result" != *"$PASSWORD"* ]] && [[ "$result" != *"DONE"* ]] && [[ "$result" != *"RENEGOTIATING"* ]] && [[ -n "$result" ]]; then
    echo -e "\n>>> 🎉 Mot de passe trouvé sur le port $port :"
    echo "$result"
    break
  fi
done
