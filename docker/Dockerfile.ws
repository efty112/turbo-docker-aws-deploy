FROM node:22-alpine

WORKDIR /usr/src/app

RUN npm install -g pnpm
COPY ./packages/db ./packages/db
COPY ./packages/eslint-config ./packages/eslint-config
COPY ./packages/typescript-config ./packages/typescript-config

COPY ./pnpm-workspace.yaml ./pnpm-workspace.yaml
COPY ./package.json ./package.json
COPY ./turbo.json ./turbo.json

COPY ./apps/ws ./apps/ws

RUN pnpm install
RUN cd packages/db && npx prisma migrate dev && npx prisma generate && cd ../..

RUN cd apps/ws && pnpm run build && cd ../..

EXPOSE 3001

CMD [ "pnpm", "run", "start:ws" ]