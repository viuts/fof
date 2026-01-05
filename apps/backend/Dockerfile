# Use the official Golang image to create a build artifact.
FROM golang:1.24 AS builder

# Set the working directory to the app's root.
WORKDIR /app

# Copy the go.mod and go.sum files.
COPY ./apps/backend/go.mod ./apps/backend/go.sum ./

# Download dependencies.
RUN go mod download

# Copy local modules (infra/protos/etc) if needed, or just the backend source
# Since the go.mod might reference local paths, we need to be careful.
# Assuming standard layout where we build from root context.
COPY . .

# Build the binary.
# Adjust the path to your main package.
RUN CGO_ENABLED=0 GOOS=linux go build -v -o server ./apps/backend/cmd/tabelog-crawler

# Use a Docker multi-stage build to create a lean production image.
FROM alpine:3

# Copy the binary to the production image from the builder stage.
COPY --from=builder /app/server /server

# Run the web service on container startup.
CMD ["/server"]
