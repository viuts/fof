package middleware

import (
	"context"
	"log"
	"net/http"
	"strings"

	firebase "firebase.google.com/go/v4"
	"github.com/viuts/fof/apps/backend/internal/repository"
)

type ContextKey string

const ContextKeyUserID ContextKey = "userID"

type AuthMiddleware struct {
	app  *firebase.App
	repo repository.FlavorRepository
}

func NewAuthMiddleware(app *firebase.App, repo repository.FlavorRepository) *AuthMiddleware {
	return &AuthMiddleware{
		app:  app,
		repo: repo,
	}
}

func (m *AuthMiddleware) Handle(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		// Skip auth for OPTIONS (handled by CORS)
		if r.Method == http.MethodOptions {
			next.ServeHTTP(w, r)
			return
		}

		authHeader := r.Header.Get("Authorization")
		if authHeader == "" {
			// For now, return 401. Later might allow optional auth.
			http.Error(w, "missing authorization header", http.StatusUnauthorized)
			return
		}

		token := strings.TrimPrefix(authHeader, "Bearer ")
		if token == "" {
			http.Error(w, "invalid authorization header", http.StatusUnauthorized)
			return
		}

		client, err := m.app.Auth(r.Context())
		if err != nil {
			log.Printf("error getting auth client: %v", err)
			http.Error(w, "internal server error", http.StatusInternalServerError)
			return
		}

		// Verify ID Token
		parsedToken, err := client.VerifyIDToken(r.Context(), token)
		if err != nil {
			log.Printf("error verifying token: %v", err)
			http.Error(w, "invalid token", http.StatusUnauthorized)
			return
		}

		// Sync user with DB
		firebaseUID := parsedToken.UID
		email := ""
		if e, ok := parsedToken.Claims["email"]; ok {
			email = e.(string)
		}

		user, err := m.repo.GetOrCreateUser(r.Context(), firebaseUID, email)
		if err != nil {
			log.Printf("error syncing user: %v", err)
			http.Error(w, "internal server error", http.StatusInternalServerError)
			return
		}

		// Set UserID in context
		ctx := context.WithValue(r.Context(), ContextKeyUserID, user.ID.String())
		next.ServeHTTP(w, r.WithContext(ctx))
	})
}
