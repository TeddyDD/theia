module caddy

go 1.13

require (
	github.com/BTBurke/caddy-jwt v3.7.1+incompatible
	github.com/caddyserver/caddy v1.0.4
	github.com/captncraig/cors v0.0.0-20190703115713-e80254a89df1
	github.com/jung-kurt/caddy-pubsub v0.0.0-00010101000000-000000000000
	github.com/lucaslorentz/caddy-supervisor v0.3.1
	github.com/nicolasazrak/caddy-cache v0.3.4
	github.com/pquerna/cachecontrol v0.0.0-20180517163645-1555304b9b35 // indirect
	github.com/tarent/loginsrv v1.3.1
	github.com/xuqingfeng/caddy-rate-limit v1.6.6
)

replace github.com/jung-kurt/caddy-pubsub => github.com/wahello/caddy-pubsub v0.5.6
