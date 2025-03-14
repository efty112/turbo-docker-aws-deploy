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

RUN echo "DATABASE_URL=$DATABASE_URL" > packages/db/.env
RUN cd packages/db && npx prisma generate && cd ../..

RUN pnpm run build

RUN rm -f /usr/src/app/packages/db/.env

EXPOSE 3001

CMD [ "pnpm", "run", "start:ws" ]