# ---------- Base ----------
FROM node:14.2.0 as base
WORKDIR /app
RUN git clone https://github.com/lacchain/eosio-writer-middleware .


# ---------- Builder ----------
FROM base AS builder
COPY --from=base /app/package.json /app/yarn.lock ./
RUN yarn --ignore-optional --frozen-lockfile
COPY --from=base /app/src ./src


# ---------- Release ----------
FROM base AS release
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/src ./src
USER root
CMD ["node", "./src/index.js"]