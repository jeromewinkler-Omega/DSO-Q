FROM node:26-alpine as builder

WORKDIR /app

ARG BLOG_ENABLED=false
ARG DEPLOYMENT_URL="gh_pages"
ARG DEPLOYMENT_BRANCH="main"
ARG GITHUB_ORG="jeromewinkler-Omega"
ARG GITHUB_PROJECT="DSO-Q"

COPY . $WORKDIR

RUN npm ci && npm run build

FROM nginx:latest as runner

COPY --from=builder /app/build /usr/share/nginx/html