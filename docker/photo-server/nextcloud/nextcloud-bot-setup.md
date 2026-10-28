# Add a bot to Nextcloud Talk

1. Enter the Docker container

   ```bash
   sudo docker exec -it nextcloud-aio-nextcloud bash
   ```

2. Run the create bot command

   ```bash
   php occ talk:bot:create <name>
   ```

3. Add the bot to the chat
