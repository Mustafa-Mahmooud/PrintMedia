# Print Media

Arabic RTL product catalog for printing machines, printers, inks, toner, spare parts, and printing supplies. Customers contact the company through WhatsApp; there is no cart or checkout.

## Local setup

```powershell
bundle install
bin/rails db:prepare
$env:WHATSAPP_NUMBER="201002334181"
bin/rails db:seed
bin/dev
```

Open `http://localhost:3000`. Admin login is at `/admins/sign_in`.

To create an admin during seeding:

```powershell
$env:ADMIN_EMAIL="admin@example.com"
$env:ADMIN_PASSWORD="use-a-secure-password"
bin/rails db:seed
```

## Deploy with Kamal

The application is configured to run in production with SQLite and Active Storage on the persistent `print_media_storage` volume. You need a Linux VPS with Docker, SSH access, and a container registry.

1. Edit `config/deploy.yml` and replace `192.168.0.1` with the VPS IP. Set the registry server/image to your Docker Hub or GitHub Container Registry image.
2. Make sure `config/master.key` exists locally and is not committed.
3. Set the registry password/token in your environment as required by `config/deploy.yml`.
4. Deploy from the project root:

```powershell
$env:KAMAL_REGISTRY_PASSWORD="your-registry-token"
bin/kamal setup
bin/kamal deploy
```

Set `WHATSAPP_NUMBER` and create the production admin after deployment:

```powershell
bin/kamal app exec --interactive --reuse "bin/rails console"
```

Then in the Rails console:

```ruby
Admin.create!(email: "admin@example.com", password: "use-a-secure-password")
SiteSetting.find_or_initialize_by(key: "whatsapp_number").update!(value: "201002334181")
```

For a custom domain, uncomment and configure the `proxy` section in `config/deploy.yml`, then enable `config.assume_ssl` and `config.force_ssl` in production.

## Checks

```powershell
bin/rails test
bin/rails routes
```
