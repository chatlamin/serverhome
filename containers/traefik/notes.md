# notes
Генерация логина пароля

    htpasswd -nb admin "EGh6lahp6sohy"

В помощь с настройкой cloudflare + traefik https://medium.com/@leandrobarral/traefik-2-setup-reverse-proxy-with-lets-encrypt-and-cloudflare-support-46d68b39ca71

В каталоге serverhome/containers/traefik создайте файл settings-secret.sh, в котором укажите переменные:

`Почта https://doc.traefik.io/traefik/user-guides/docker-compose/acme-tls/#setup`

    SECRET_EMAIL=

`Global API key cloudflare`

    CLOUDFLARE_EMAIL=
    CLOUDFLARE_API_KEY=

Настройка TLS Challenge https://doc.traefik.io/traefik/user-guides/docker-compose/acme-tls/