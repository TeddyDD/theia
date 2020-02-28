package main

import (
	"github.com/caddyserver/caddy/caddy/caddymain"

	// plug in plugins here, for example:
	// _ "import/path/here"
	_ "github.com/BTBurke/caddy-jwt"
	_ "github.com/captncraig/cors"
	_ "github.com/jung-kurt/caddy-pubsub"
	_ "github.com/lucaslorentz/caddy-supervisor/httpplugin"
	_ "github.com/lucaslorentz/caddy-supervisor/servertype"
	_ "github.com/nicolasazrak/caddy-cache"
	_ "github.com/tarent/loginsrv/caddy"
	_ "github.com/xuqingfeng/caddy-rate-limit"
)

func main() {
	// optional: disable telemetry
	caddymain.EnableTelemetry = false
	caddymain.Run()
}
